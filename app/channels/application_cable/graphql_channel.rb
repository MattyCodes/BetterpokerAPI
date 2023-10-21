class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    @subscription_ids = []
  end

  def execute(data)
    query = data['query']
    variables = ensure_hash(data['variables'])
    operation_name = data['operationName']

    context = {
      channel: self,
      current_application_context: connection.current_application_context
    }

    result = BetterpokerApiSchema.execute({
      query: query,
      context: context,
      variables: variables,
      operation_name: operation_name
    })

    payload = { result: result.to_h, more: result.subscription? }

    @subscription_ids << result.context[:subscription_id] if result.context[:subscription_id].present?
    transmit(payload)
  end

  def unsubscribed
    @subscription_ids.each do |id|
      BetterpokerApiSchema.subscriptions.delete_subscription(id)
    end
  end
end
