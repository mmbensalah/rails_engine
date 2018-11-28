class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute JSON.parse(":id") 
end
