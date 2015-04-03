module StripeMock
  module RequestHandlers
    module Discounts

      def Discounts.included(klass)
        klass.add_handler 'post /v1/customers/(.*)/discount', :delete_customer_discount
        klass.add_handler 'delete /v1/customers/(.*)/subscriptions/(.*)/discount', :delete_subscription_discount
      end

      def delete_customer_discount(route, method_url, params, headers)
        route =~ method_url
        customer = assert_existence :customer, $1, customers[$1]

        discount = get_customer_discount(customer)
        id = discount[:id]
        assert_existence :discount, id, discount

        customer[:discount] = nil
        discounts[$1] = {
          id: id,
          deleted: true
        }
      end

      def delete_subscription_discount(route, method_url, params, headers)
        route =~ method_url
        customer = assert_existence :customer, $1, customers[$1]

        subscription = get_customer_subscription(customer, $2)
        assert_existence :subscription, $2, subscription

        discount = get_subscription_discount(subscription)
        id = discount[:id]
        assert_existence :discount, id, discount

        subscription[:discount] = nil
        discounts[$1] = {
          id: id,
          deleted: true
        }
      end
    end
  end
end
