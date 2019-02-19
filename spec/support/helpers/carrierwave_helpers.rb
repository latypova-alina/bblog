module CarrierwaveHelpers
  def attach_file(field_name)
    page.attach_file(field_name, Rails.root + "spec/support/fixtures/post_image_1.jpg")
  end
end
