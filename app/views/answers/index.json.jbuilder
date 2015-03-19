json.array!(@answers) do |answer|
  json.extract! answer, :id, :question_id, :select_id, :active_flg, :delete_flg
  json.url answer_url(answer, format: :json)
end
