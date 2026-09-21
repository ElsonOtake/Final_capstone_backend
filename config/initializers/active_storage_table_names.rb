# frozen_string_literal: true

Rails.application.config.to_prepare do
  ActiveStorage::Blob.table_name = 'exo_active_storage_blobs'
  ActiveStorage::Attachment.table_name = 'exo_active_storage_attachments'
  ActiveStorage::VariantRecord.table_name = 'exo_active_storage_variant_records'
end
