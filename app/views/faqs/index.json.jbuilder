json.array!(@faqs) do |faq|
  json.extract! faq, :question, :answer
  json.url faq_url(faq, format: :json)
end
