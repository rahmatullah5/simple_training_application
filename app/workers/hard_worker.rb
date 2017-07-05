class HardWorker
  include Sidekiq::Worker

  def perform(order,cart,email)
    UserMailer.UserMailerView(order,cart,email).deliver
  end
end
