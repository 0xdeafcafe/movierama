class VoteNotifierJob
  include SuckerPunch::Job
  workers 2

  def perform(like_or_hate, user, movie)
    # Send an email to the movie owner telling about the (maybe..) good news
    UserNotifierMailer.send_vote_notification(like_or_hate, user, movie).deliver
  end
end
