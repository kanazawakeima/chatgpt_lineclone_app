class TeamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @team = Team.find_by(user_id: @user.id)
  end

  def create
    @team = Team.new(user_id: current_user.id)
    customer = Stripe::Customer.create({
      source: params[:stripeToken]
    })
    subscription = Stripe::Subscription.create({
      customer: customer.id,
      plan: "price_1MwiLIH9VISkxUuRHaqx9RPj"
    })
    @team.plan_id = "price_1MwiLIH9VISkxUuRHaqx9RPj"
    @team.customer_id = customer.id
    @team.stripe_subscription_id = subscription.id
    @team.active_until = Time.zone.at(subscription.current_period_end)
    if @team.save
      flash[:success] = "成功しました"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    @team = Team.find_by(user_id: current_user.id)
    deleting_stripe_subscription = Stripe::Subscription.retrieve(@team.stripe_subscription_id)
    if current_user.unsubscribe
      deleting_stripe_subscription.delete
      flash[:notice] = "解約に成功しました"
      redirect_to root_url
    else
      render 'new'
    end
  end
end
