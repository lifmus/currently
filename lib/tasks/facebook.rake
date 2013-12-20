namespace :facebook do

  desc 'Create users based on Facebook friends'
  task create_users: :environment do
    User.where(email: 'andrew@andrewlin.net').each do |user|
      @graph = Koala::Facebook::API.new(user.oauth_token)
      profile = @graph.get_object('me')
      friends = @graph.get_connections('me', 'friends')
      friends.each do |friend|
        User.find_or_initialize_by(uid: friend['id']) do |user|
          user.name = friend['name']
          user.password = SecureRandom.hex(5) unless !user.password.blank?
          user.slug = user.auto_generate_slug unless !user.slug.blank?
          user.save! ? (puts user.name + ' updated!') : user.errors.full_messages.to_sentence
        end
      end
    end
  end

end