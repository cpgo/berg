RSpec.shared_context 'main curated_posts' do

  def create_curated_post(title)
    Berg::Container["persistence.commands.create_curated_post"].({
      title: title,
      website_url: "http://foo.bar",
      image_url: "http://foo.bar/image.png",
      image_upload: nil,
      status: "published",
      published_at: Time.now
    })
  end
end