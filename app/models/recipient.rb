class Recipient < ActiveRecord::Base
	belongs_to :user
	has_many :scans
	has_many :events
	attr_accessible :user_id, :alias

	def checkout_url
		@scans = self.scans.limit(10)

		base_request = {:operation => "CartCreate", :service => "AWSECommerceService"}

		i = 1
		#oh the humanity. forgive me; someday I will refactor this.

		@scans.each do |scan|

			product_resp = scan.get_response
			asin = product_resp.items.first.get('Offers/Offer/OfferListing/OfferListingId')
			unless asin.nil?
				base_request = base_request.merge({"Item.#{i}.OfferListingId" => asin, "Item.#{i}.Quantity" => 1})
				i+=1
			end
		end

		final_resp = Amazon::Ecs.send_request(base_request)
		url = Amazon::Element.get(final_resp.doc,"//PurchaseURL")
		unless url.nil?
			Amazon::Element.get(final_resp.doc,"//PurchaseURL")
		else
			""
		end
		#it works. ... why. :(
	end

	def alias_for_collection
		"#{self.alias}"
	end



end
