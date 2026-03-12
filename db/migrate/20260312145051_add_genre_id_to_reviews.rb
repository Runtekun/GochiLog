class AddGenreIdToReviews < ActiveRecord::Migration[7.2]
  def change
    add_reference :reviews, :genre, null: true, foreign_key: true
  end
end
