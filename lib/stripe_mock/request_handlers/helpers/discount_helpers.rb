module StripeMock
  module RequestHandlers
    module Helpers

      def apply_coupon_to_subscription(subscription, coupon)
        subscription[:discount] = Data.mock_discount({id: new_id('di'),
                                                      coupon: coupon,
                                                      subscription: subscription[:id]})
      end

      def apply_coupon_to_customer(customer, coupon)
        customer[:discount] = Data.mock_discount({id: new_id('di'),
                                                  coupon: coupon,
                                                  customer: customer[:id]})
      end

      def get_customer_discount(customer)
        customer[:discount]
      end

      def get_subscription_discount(subscription)
        customer[:subscription]
      end
    end
  end
end
