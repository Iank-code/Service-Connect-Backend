class ServiceProviderSerializer < ActiveModel::Serializer
  attributes :id, :image_url

  def image_url
   blob = ActiveStorage::Blob.find(params[:id])
    if blob.present?
      send_data blob.service.download(blob.key), filename: blob.filename.to_s, type: blob.content_type
    else
      head :not_found
    end

  end
end
