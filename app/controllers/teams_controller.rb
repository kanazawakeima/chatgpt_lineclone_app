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
      current_user.update(is_subscribed: true)
      flash[:notice] = "成功しました"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    current_user.update(is_subscribed: false)

    respond_to do |format|
      format.html { redirect_to chats_url, notice: "解約しました。" }
      format.json { head :no_content }
    end
  end
end
