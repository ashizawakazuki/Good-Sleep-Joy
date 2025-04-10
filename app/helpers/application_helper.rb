module ApplicationHelper
  def page_title(title = '')
    base_title = 'Good Sleep Joy'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def default_meta_tags
    {
      site: 'Good-Sleep-Joy',
      title: 'Good-Sleep-Joy（睡眠サポートアプリ）',
      reverse: true,
      charset: 'utf-8',
      description: '質の高い睡眠をとるためのアイテムや習慣を共有できます。
      また、1日の最後にその日楽しかった出来事を3つ書き出すことで、毎日ポジティブな気持ちで眠りにつくことができます。',
      canonical: "https://good-sleep-joy.com/",
      separator: '|',
      # icon: [
      #   { href: image_url('logo.png') },
      #   { href: image_url('top_image.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      # ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: "https://good-sleep-joy.com/",
        image: "https://good-sleep-joy.com/assets/ogp-074a5399428fc21d28053882383bdcd9a16ce9474e7560ea0f7f245e97148b.png",
        local: 'ja-JP',
      },
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードに変更
        image: image_url('ogp.png'),# 配置するパスやファイル名によって変更
      }
    }
  end

end
