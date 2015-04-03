
require 'spec_helper'

shared_examples 'Discount API' do

  def gen_card_tk
    stripe_helper.generate_card_token
  end

  it "deletes a customer discount" do
    coupon = Stripe::Coupon.create(
      :id => '10BUCKS',
      :amount_off => 1000,
      :currency => 'USD',
      :max_redemptions => 100,
      :metadata => {
        :created_by => 'admin_acct_1',
      },
    )
    customer = Stripe::Customer.create(coupon: coupon.id)
    expect(customer.discount).to_not eq(nil)
    customer = customer.delete_discount
    expect(customer.discount).to eq(nil)
  end

  it "deletes a subscription discount" do
    coupon = Stripe::Coupon.create(
      :id => '10BUCKS',
      :amount_off => 1000,
      :currency => 'USD',
      :max_redemptions => 100,
      :metadata => {
        :created_by => 'admin_acct_1',
      },
    )
    stripe_helper.create_plan(id: 'the truth')
    customer = Stripe::Customer.create(source: gen_card_tk)
    subscription = customer.subscriptions.create(plan: "the truth", coupon: coupon.id)

    expect(subscription.discount).to_not eq(nil)
    subscription.delete_discount
    expect(subscription.discount).to eq(nil)
  end
end
