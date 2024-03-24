resource "aws_s3_bucket" "example" {
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.example.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#検証終了時にS3バケット内のファイルを全削除する
#参考：https://qiita.com/ChaseSan/items/11fe05926c700220d3cc
resource "null_resource" "example" {
  triggers = {
    bucket   = aws_s3_bucket.example.bucket
  }
  depends_on = [
    aws_s3_bucket.example
  ]
  provisioner "local-exec" {
    when = destroy
    command = "aws s3 rm s3://${self.triggers.bucket} --recursive"
  }
}