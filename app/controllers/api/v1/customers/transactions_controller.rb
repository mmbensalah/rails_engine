class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    invoices = Customer.find(params[:id]).invoices

    transactions = invoices.map do |object|
                    Transaction.find(object.id)
                  end
    render json: TransactionSerializer.new(transactions)
  end
end
