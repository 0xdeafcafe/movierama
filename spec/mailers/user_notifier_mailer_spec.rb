require 'rails_helper'

RSpec.describe UserNotifierMailer, :type => :mailer do
  let(:user) { instance_double('User', email: 'john@example.com', name: 'John McFoo', id: 123) }
  let(:user_movie_owner) { instance_double('User', email: 'alice@example.com', name: 'Alice Wallace', id: 456) }
  let(:movie) { instance_double('Movie', title: 'Test Movie', user: user_movie_owner) }

  let(:liked_email) { UserNotifierMailer.send_vote_notification(:like, user, movie) }
  let(:hated_email) { UserNotifierMailer.send_vote_notification(:hate, user, movie) }

  let(:liked) { 'liked' }
  let(:hated) { 'hated' }

  describe 'notify user' do
    context 'liked movie' do
      it 'has the correct from address' do
        expect(liked_email.from).to eql ['no-reply@movierama.dev']
      end

      it 'has the correct to address' do
        expect(liked_email.to).to eql [movie.user.email]
      end

      it 'has the correct subject' do
        expect(liked_email.subject).to eql "#{user.name} has just liked your movie on MovieRama!"
      end

      it 'assigns @movie.user.name' do
        expect(liked_email.body.encoded).to match("Hi #{movie.user.name}!")
      end

      it 'assigns @user.name' do
        expect(liked_email.body.encoded).to match(user.name)
      end

      it 'assigns @friendly_like_or_hate' do
        expect(liked_email.body.encoded).to match(liked)
      end

      it 'assigns @movie.title' do
        expect(liked_email.body.encoded).to match(movie.title)
      end
    end

    context 'hated movie' do
      it 'has the correct from address' do
        expect(hated_email.from).to eql ['no-reply@movierama.dev']
      end

      it 'has the correct to address' do
        expect(hated_email.to).to eql [movie.user.email]
      end

      it 'has the correct subject' do
        expect(hated_email.subject).to eql "#{user.name} has just hated your movie on MovieRama!"
      end

      it 'assigns @friendly_like_or_hate' do
        expect(hated_email.body.encoded).to match(hated)
      end

      it 'assigns @movie.user.name' do
        expect(hated_email.body.encoded).to match("Hi #{movie.user.name}!")
      end

      it 'assigns @user.name' do
        expect(hated_email.body.encoded).to match(user.name)
      end

      it 'assigns @movie.title' do
        expect(hated_email.body.encoded).to match(movie.title)
      end
    end
  end
end
