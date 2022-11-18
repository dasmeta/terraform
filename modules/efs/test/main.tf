module "efs" {
  source                   = "dasmeta/modules/aws//modules/efs"
  creation_token           = "EFS"
  availability_zone_prefix = "a"
  encrypted                = true
  kms_key_id               = aws_kms_key.key.id
  performance_mode         = "generalPurpose"
  throughput_mode          = "bursting"
}

resource "aws_kms_key" "key" {
  description             = "kms-key"
  deletion_window_in_days = 10
}
