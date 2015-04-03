module StripeMock
  module RequestHandlers
    module Helpers

      def get_customer_discount(customer)
        customer[:discount]
      end

      def get_subscription_discount(subscription)
        customer[:subscription]
      end
    end
  end
end
