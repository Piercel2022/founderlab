# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Clear existing data
puts "Cleaning database..."
[User, Project, Event, Resource, Mentor, Meeting, Forum, Post, Subscription].each(&:destroy_all)

# Create Admin
puts "Creating admin user..."
admin = User.create!(
  email: 'admin@founderlab.com',
  password: 'Password@123',
  name: 'Admin User',
  username: 'admin_user',
  role: 'admin',
  company: 'FounderLab',
  bio: 'Platform administrator'
)

# Create Users
puts "Creating users..."
10.times do |i|
  User.create!(
    email: "founder#{i}@example.com",
    password: 'Password@123',
    name: Faker::Name.name,
    role: 'founder',
    company: Faker::Company.name,
    bio: Faker::Company.catch_phrase,
    status: 'active'
  )
end

# Create Mentors
puts "Creating mentors..."
mentors = 5.times.map do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'Password@123',
    name: Faker::Name.name,
    role: 'mentor',
    company: Faker::Company.name,
    bio: Faker::Lorem.paragraph
  )

  Mentor.create!(
    user: user,
    expertise: ['Marketing', 'Finance', 'Technology', 'Sales'].sample(2),
    availability: ['Morning', 'Afternoon', 'Evening'].sample,
    rating: rand(3.5..5.0).round(1),
    sessions_count: rand(10..50),
    status: 'active'
  )
end

# Create Projects
puts "Creating projects..."
20.times do
  project = Project.create!(
    name: Faker::Company.name,
    description: Faker::Company.catch_phrase + ". " + Faker::Company.bs,
    status: ['draft', 'active', 'completed', 'archived'].sample,
    user: User.where(role: 'founder').sample,
    target_market: Faker::Company.industry,
    revenue_model: ['Subscription', 'Marketplace', 'SaaS', 'E-commerce'].sample,
    featured: [true, false].sample,
    success_story: [true, false].sample,
    industry: Faker::Industry.industry,
    stage: ['Idea', 'MVP', 'Growth', 'Scale'].sample,
    team_size: rand(1..20),
    total_investment: rand(10000..1000000)
  )

  # Create Development Project for each project
  DevelopmentProject.create!(
    project: project,
    phase: ['planning', 'development', 'testing', 'launch'].sample,
    timeline: Date.today + rand(30..180).days,
    budget: rand(5000..50000),
    tech_stack: ['Ruby on Rails', 'React', 'Node.js', 'Python'].sample(2),
    milestones: {
      'milestone1': 'Project Setup',
      'milestone2': 'MVP Development',
      'milestone3': 'Testing Phase',
      'milestone4': 'Launch'
    }
  )

  # Create Market Research for each project
  MarketResearch.create!(
    project: project,
    market_size: rand(1000000..10000000),
    competitors: Faker::Company.name,
    target_audience: Faker::Demographics.demographic,
    pain_points: ['Cost', 'Efficiency', 'Access'].sample(2),
    opportunities: ['Market Gap', 'Technology Advancement', 'Growing Demand'].sample(2)
  )
end

# Create Events
puts "Creating events..."
15.times do
  Event.create!(
    title: "#{['Workshop', 'Seminar', 'Conference', 'Meetup'].sample} on #{Faker::Company.buzzword}",
    description: Faker::Lorem.paragraph,
    date: Date.today + rand(1..60).days,
    location: "#{Faker::Address.city} Convention Center",
    capacity: rand(20..200),
    category: ['workshop', 'networking', 'pitch', 'conference'].sample
  )
end

# Create Resources
puts "Creating resources..."
categories = ['document', 'video', 'template', 'tool']
access_levels = ['free', 'premium', 'enterprise']

20.times do
  Resource.create!(
    title: "#{Faker::Company.buzzword} #{Faker::Company.industry} Guide",
    description: Faker::Lorem.paragraph,
    category: categories.sample,
    file_url: "https://example.com/resources/#{Faker::Alphanumeric.alpha(number: 10)}",
    access_level: access_levels.sample
  )
end

# Create Forums
puts "Creating forums..."
forums = 5.times.map do
  Forum.create!(
    title: "#{Faker::Company.industry} Discussion",
    description: Faker::Lorem.paragraph,
    category: ['general', 'technical', 'funding', 'growth'].sample,
    status: 'active'
  )
end

# Create Posts
puts "Creating forum posts..."
forums.each do |forum|
  10.times do
    Post.create!(
      forum: forum,
      user: User.all.sample,
      content: Faker::Lorem.paragraphs(number: 2).join("\n\n"),
      status: 'active'
    )
  end
end

# Create Subscriptions
puts "Creating subscriptions..."
User.where(role: 'founder').each do |user|
  Subscription.create!(
    user: user,
    plan_type: ['basic', 'pro', 'enterprise'].sample,
    start_date: Date.today - rand(1..30).days,
    end_date: Date.today + rand(30..365).days,
    status: ['active', 'cancelled', 'expired'].sample,
    amount: [29, 99, 299].sample
  )
end

# Create Meetings
puts "Creating meetings..."
30.times do
  Meeting.create!(
    mentor: Mentor.all.sample,
    user: User.where(role: 'founder').sample,
    date: DateTime.now + rand(1..30).days,
    status: ['scheduled', 'completed', 'cancelled'].sample,
    notes: Faker::Lorem.paragraph,
    meeting_type: ['one_on_one', 'group', 'workshop'].sample
  )
end

# Success stories
SuccessStory.create([
  {
    title: "Revolutionary AI Platform",
    founder_name: "Sarah Johnson",
    founder_avatar: "path/to/avatar1.jpg",
    company_name: "TechAI Solutions",
    industry: "Artificial Intelligence",
    summary: "Built an AI platform that revolutionized natural language processing...",
    funding_raised: "$5M",
    team_size: 25,
    image_url: "path/to/company1.jpg"
  },
  {
    title: "Sustainable Fashion Marketplace",
    founder_name: "Michael Chen",
    founder_avatar: "path/to/avatar2.jpg",
    company_name: "EcoStyle",
    industry: "Fashion Technology",
    summary: "Created a marketplace connecting sustainable fashion brands...",
    funding_raised: "$2.5M",
    team_size: 15,
    image_url: "path/to/company2.jpg"
  }
])
Startup.where(location: "San Francisco").select(:id, :name, :location).each do |startup|
  puts "Startup: #{startup.name}, Location: #{startup.location}"
end


puts "Seed completed successfully!"
puts "Created:"
puts "- #{User.count} users (#{User.where(role: 'founder').count} founders)"
puts "- #{Mentor.count} mentors"
puts "- #{Project.count} projects"
puts "- #{Event.count} events"
puts "- #{Resource.count} resources"
puts "- #{Forum.count} forums with #{Post.count} posts"
puts "- #{Meeting.count} meetings"
puts "- #{Subscription.count} subscriptions"
puts "- #{SuccessStory.count} successtories"
