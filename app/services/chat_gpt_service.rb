class ChatGPTService
  BASE_URL = "https://api.openai.com/v1/chat/completions"
  OPENAI_API_KEY =  ENV.fetch('OPENAI_API_KEY') 

  def initialize()
    @errors = []
  end

  def generate_response(prompt)
    response = HTTParty.post(
      "#{BASE_URL}",
      headers: {
        "Authorization" => "Bearer #{OPENAI_API_KEY}",
        "Content-Type" => "application/json"
      },
      
      body: { model: "gpt-3.5-turbo-instruct", messages: [{ role: "system", content: "You are a helpful assistant." }, { role: "user", content: prompt }] }.to_json
    )
    puts response
    JSON.parse(response.body)["choices"][0]["message"]["content"]
  rescue => error
    @errors.push(error)
  end
end
