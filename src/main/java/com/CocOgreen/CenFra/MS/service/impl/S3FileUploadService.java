package com.CocOgreen.CenFra.MS.service.impl;

import com.CocOgreen.CenFra.MS.dto.UploadedFileResult;
import com.CocOgreen.CenFra.MS.exception.FileUploadException;
import com.CocOgreen.CenFra.MS.service.FileUploadService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.exception.SdkException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.GetUrlRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.IOException;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class S3FileUploadService implements FileUploadService {

    private final S3Client s3Client;

    @Value("${aws.s3.bucket:}")
    private String bucket;

    @Value("${aws.s3.public-base-url:}")
    private String publicBaseUrl;

    @Override
    public UploadedFileResult uploadFileWithMetadata(MultipartFile file, String folder) {
        if (file == null || file.isEmpty()) {
            throw new FileUploadException("File gửi lên không được trống.");
        }
        if (bucket == null || bucket.isBlank()) {
            throw new FileUploadException("AWS S3 bucket chưa được cấu hình.");
        }

        String key = buildObjectKey(folder, file.getOriginalFilename());
        try {
            log.info("Bắt đầu upload file lên S3 bucket {} với key {}...", bucket, key);

            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(key)
                    .contentType(file.getContentType())
                    .contentLength(file.getSize())
                    .build();

            s3Client.putObject(
                    putObjectRequest,
                    RequestBody.fromInputStream(file.getInputStream(), file.getSize()));

            String secureUrl = buildPublicUrl(key);
            log.info("Upload S3 thành công. URL: {}", secureUrl);
            return new UploadedFileResult(secureUrl, key);
        } catch (IOException | SdkException e) {
            log.error("Lỗi khi upload file lên S3", e);
            throw new FileUploadException("Có lỗi xảy ra khi xử lý file tải lên: " + e.getMessage(), e);
        }
    }

    @Override
    public void deleteFile(String publicId) {
        if (publicId == null || publicId.isBlank()) {
            return;
        }
        if (bucket == null || bucket.isBlank()) {
            throw new FileUploadException("AWS S3 bucket chưa được cấu hình.");
        }

        try {
            s3Client.deleteObject(DeleteObjectRequest.builder()
                    .bucket(bucket)
                    .key(publicId)
                    .build());
        } catch (SdkException e) {
            log.error("Lỗi khi xóa file khỏi S3", e);
            throw new FileUploadException("Có lỗi xảy ra khi xóa file trên S3: " + e.getMessage(), e);
        }
    }

    private String buildObjectKey(String folder, String originalFilename) {
        String safeFolder = sanitizeFolder(folder);
        String extension = extractExtension(originalFilename);
        return safeFolder + "/" + UUID.randomUUID() + extension;
    }

    private String sanitizeFolder(String folder) {
        String sanitized = folder == null || folder.isBlank() ? "uploads" : folder.trim();
        sanitized = sanitized.replaceAll("[^a-zA-Z0-9/_-]", "-");
        sanitized = sanitized.replaceAll("^/+", "").replaceAll("/+$", "");
        return sanitized.isBlank() ? "uploads" : sanitized;
    }

    private String extractExtension(String originalFilename) {
        if (originalFilename == null || originalFilename.isBlank()) {
            return "";
        }

        String filename = originalFilename.replace("\\", "/");
        filename = filename.substring(filename.lastIndexOf('/') + 1);
        int dotIndex = filename.lastIndexOf('.');
        if (dotIndex < 0 || dotIndex == filename.length() - 1) {
            return "";
        }
        return filename.substring(dotIndex).replaceAll("[^a-zA-Z0-9.]", "");
    }

    private String buildPublicUrl(String key) {
        if (publicBaseUrl != null && !publicBaseUrl.isBlank()) {
            return publicBaseUrl.replaceAll("/+$", "") + "/" + key;
        }

        return s3Client.utilities()
                .getUrl(GetUrlRequest.builder()
                        .bucket(bucket)
                        .key(key)
                        .build())
                .toExternalForm();
    }
}
