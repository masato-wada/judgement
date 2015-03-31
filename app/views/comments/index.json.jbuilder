json.array!(@comments) do |comment|
  json.extract! comment, :id, :question_id, :select_id, :answer_id, :comment, :active_flg, :delete_flg
  json.url comment_url(comment, format: :json)
end
