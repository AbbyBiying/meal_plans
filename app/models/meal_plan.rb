class MealPlan < ApplicationRecord
  after_create :queue_chat_job

  private
    def queue_chat_job
      GetResponseJob.perform_later self.id
    end
end
