class UserNotifierMailer < ActionMailer::Base
  default from: 'MovieRama <no-reply@movierama.dev>'

  def send_vote_notification(like_or_hate, user, movie)
    @user = user
    @movie = movie
    @friendly_like_or_hate = "#{like_or_hate}d"

    # Send mails
    mail(
        :to => @movie.user.email,
        :subject => "#{@user.name} has just #{@friendly_like_or_hate} your movie on MovieRama!"
    )
  end
end
