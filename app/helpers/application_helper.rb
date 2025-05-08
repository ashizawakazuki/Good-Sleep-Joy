module ApplicationHelper
  def page_title(title = '')
    base_title = 'Good Sleep Joy'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    site = options[:site] || 'Good Sleep Joy'
    title = options[:title] || 'Good Sleep Joy（睡眠サポートアプリ）'
    description = options[:description] || '質の高い睡眠をとるためのアイテムや習慣を共有できます。'
    image = options[:image].presence || image_url('ogp.png') # デフォルト画像

    set_meta_tags(
      site: site,
      title: title,
      reverse: true,
      charset: 'utf-8',
      description: description,
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: site,
        title: title,
        description: description,
        type: 'website',
        url: request.original_url,
        image: image, # 動的画像
        locale: 'ja-JP',
      },
      twitter: {
        card: 'summary_large_image',
        image: image, # Twitter用の動的画像
      }
    )
  end
end