require 'spec_helper'

describe "Subscription" do
	ProductAttributes = {
		"name": "The Collegian",
		"description": "Official newsletter of CPM University",
		"type": "PHYSICAL",
		"category": "BOOKS_PERIODICALS_AND_NEWSPAPERS",
		"image_url": "https://example.com",
		"home_url": "https://example.com"
	}

	SubscriptionPlanAttributes = {
	  "name": "Monthy Subscription to the Collegian",
      "status": "ACTIVE",
      "description": "1 print copy of The Collegian delivered to your address.",
      "billing_cycles": [
        {
          "frequency": {
            "interval_unit": "MONTH",
            "interval_count": 1
          },
          "tenure_type": "TRIAL",
          "sequence": 1,
          "total_cycles": 1,
          "pricing_scheme": {
            "fixed_price": {
              "value": "0",
              "currency_code": "USD"
            }
          }
        },
        {
          "frequency": {
            "interval_unit": "MONTH",
            "interval_count": 1
          },
          "tenure_type": "REGULAR",
          "sequence": 2,
          "total_cycles": 12,
          "pricing_scheme": {
            "fixed_price": {
              "value": "29.99",
              "currency_code": "USD"
            }
          }
        }
      ],
      "payment_preferences": {
        "auto_bill_outstanding": true,
        "setup_fee": {
          "value": "0",
          "currency_code": "USD"
        },
        "setup_fee_failure_action": "CONTINUE",
        "payment_failure_threshold": 3
      },
      "taxes": {
        "percentage": "12",
        "inclusive": false
      },
      "quantity_supported": true
	}

	SubscriptionAttributes = {
	  "start_time": "2019-11-24T00:00:00Z",
	  "quantity": "3",
	  "shipping_amount": {
	    "currency_code": "USD",
	    "value": "9.00"
	  },
	  "subscriber": {
	    "name": {
	      "given_name": "John",
	      "surname": "Doe"
	    },
	    "email_address": "customer@example.com",
	    "shipping_address": {
	      "name": {
	        "full_name": "John Doe"
	      },
	      "address": {
	        "address_line_1": "2211 N First Street",
	        "address_line_2": "Building 17",
	        "admin_area_2": "San Jose",
	        "admin_area_1": "CA",
	        "postal_code": "95131",
	        "country_code": "US"
	      }
	    }
	  },
	  "application_context": {
	    "brand_name": "The Collegian",
	    "locale": "en-US",
	    "shipping_preference": "SET_PROVIDED_ADDRESS",
	    "user_action": "SUBSCRIBE_NOW",
	    "payment_method": {
	      "payer_selected": "PAYPAL",
	      "payee_preferred": "IMMEDIATE_PAYMENT_REQUIRED"
	    },
	    "return_url": "https://example.com/returnUrl",
	    "cancel_url": "https://example.com/cancelUrl"
	  }
	}

	describe "Product", :integration => true do
		it "Create" do
	      $api = API.new
	      $product = Product.new(ProductAttributes.merge( :token => $api.token ))
	      expect(Product.api).not_to eql $product.api
	      $product.create

	      # make sure the transaction was successful
	      $product_id = $product.id
	      expect($product.error).to be_nil
	      expect($product.id).not_to be_nil
	    end

	    it "Find" do
	      api = API.new
	      product = Product.find($product.id)
	      expect(product.id).to eq($product.id)
	      expect(product.name).to eq("The Collegian")
	      expect(product.type).to eq("PHYSICAL")
	    end

	    it "List" do
	    	product_list = Product.all()
      		expect(product_list.error).to be_nil
      		expect(product_list.products.count).to be > 0
	    end
	end

end