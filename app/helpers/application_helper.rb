module ApplicationHelper
  GENRE_COLORS = {
    "ラーメン"    => "bg-red-100 text-red-700",
    "カフェ"      => "bg-amber-100 text-amber-700",
    "居酒屋"      => "bg-purple-100 text-purple-700",
    "寿司"        => "bg-blue-100 text-blue-700",
    "焼肉"        => "bg-orange-100 text-orange-700",
    "イタリアン"  => "bg-green-100 text-green-700",
    "中華"        => "bg-yellow-100 text-yellow-700",
    "レストラン"  => "bg-teal-100 text-teal-700",
    "その他"      => "bg-gray-100 text-gray-600"
  }.freeze

  def genre_badge_class(genre_name)
    GENRE_COLORS[genre_name] || "bg-gray-100 text-gray-600"
  end
end
