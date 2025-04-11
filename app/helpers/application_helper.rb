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
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: "https://good-sleep-joy.com/",
        image:'https://good-sleep-joy.com/ogp.png',# 配置するパスやファイル名によって変更する
        local: 'ja-JP',
      },
      twitter: {
        card: 'summary_large_image',
        image: 'https://good-sleep-joy.com/ogp.png',# 配置するパスやファイル名によって変更
      }
    }
  end

end
