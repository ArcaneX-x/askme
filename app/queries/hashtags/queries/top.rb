module Hashtags
  module Queries
    class Top
      def self.call(count:)
        Hashtag.where(
          id: HashtagQuestion
                .select(:hashtag_id)
                .group(:hashtag_id)
                .order('COUNT(hashtag_id) desc')
        ).limit(count)
      end
    end
  end
end
