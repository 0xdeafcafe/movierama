require 'sucker_punch/testing/inline'
require 'rails_helper'
require 'spec_helper'

RSpec.describe VotingBooth, :type => :service do
  let(:relationships) {instance_double(Ohm::MutableSet, size: 1, add: true, delete: true)}

  subject { VotingBooth.new(user, movie) }
  let(:subject_own_movie) { VotingBooth.new(user_movie_owner, movie) }
  let(:user) { instance_double('User', email: 'john@example.com', name: 'John McFoo', id: 123) }
  let(:user_movie_owner) { instance_double('User', email: 'alice@example.com', name: 'Alice Wallace', id: 456) }
  let(:movie) { instance_double('Movie', user: user_movie_owner, title: 'Test Movie', likers: relationships, haters: relationships, update: true) }

  let(:subject_no_email) { VotingBooth.new(user, movie_no_email) }
  let(:user_no_email) { instance_double('User', email: nil, name: 'Bob Ablleton', id: 789) }
  let(:movie_no_email) { instance_double('Movie', user: user_no_email, title: 'Test Movie - No Email', likers: relationships, haters: relationships, update: true) }

  let(:like){:like}
  let(:hate){:hate}

  describe 'voting' do
    context 'user likes own movie' do
      it "shouldn't send email" do
        expect {subject_own_movie.vote(like)}.to change{ ActionMailer::Base.deliveries.size }.by(0)
      end
    end

    context 'user has no email' do
      it "doesn't send email" do
        expect {subject_no_email.vote(like)}.to change{ ActionMailer::Base.deliveries.size }.by(0)
      end
    end

    context 'user has email' do
      it 'sends like email' do
        expect {subject.vote(like)}.to change{ ActionMailer::Base.deliveries.size }.by(1)
      end

      it 'sends hate email' do
        expect {subject.vote(hate)}.to change{ ActionMailer::Base.deliveries.size }.by(1)
      end
    end
  end
end
