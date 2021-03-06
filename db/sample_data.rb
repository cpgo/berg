require_relative "../system/boot"
require "faker"

def core
  Berg::Container
end

def main
  Main::Container
end

def admin
  Admin::Container
end

def create_user(attrs)
  admin["users.operations.create"].call(attrs).value
end

def create_person(attrs)
  admin["people.operations.create"].call(attrs).value
end

def create_post(attrs)
  admin["posts.operations.create"].call(attrs).value
end

def create_project(attrs)
  admin["projects.operations.create"].call(attrs).value
end

def create_category(attrs)
  admin["categories.operations.create"].call(attrs).value
end

create_user(
  email: "hello@icelab.com.au",
  name: "Icelab Admin",
  active: true
)

create_person(
  name: "Icelab Person",
  bio: "An icelab person",
  short_bio: "An icelab person",
  job_title: "Developer",
  website_url: nil,
  twitter_handle: "",
  avatar_image: nil,
  city: "Melbourne",
)

author = admin["persistence.repositories.people"][1]
admin["users.operations.change_password"].(1, password: "changeme")

20.times do
  create_post(
    title: Faker::Hipster.sentence,
    teaser: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph,
    status: "published",
    person_id: author.id,
    published_at: Time.now,
    cover_image: nil,
    categories: [1],
    assets: [{}]
  )
end

20.times do
  create_project(
    title: Faker::Hipster.sentence,
    client: Faker::Company.name,
    url: Faker::Internet.url,
    intro: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph,
    status: "draft",
    case_study: false,
    cover_image: nil,
    summary: Faker::Hipster.sentence
  )
end

{
  ruby: "Ruby",
  dry_web: "dry-web",
  rails: "Rails",
  javascript: "Javascript",
  ios: "iOS",
  design: "Design",
  react: "React"
}.each do |slug, name|
  create_category(name: name, slug: slug.to_s)
end
