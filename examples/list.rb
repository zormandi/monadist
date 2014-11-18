require 'monadist'
require 'monadist/shims'

Blog = Struct.new :categories
Category = Struct.new :posts
Post = Struct.new :comments



def words_in(blogs)
  blogs.flat_map do |blog|
    blog.categories.flat_map do |category|
      category.posts.flat_map do |post|
        post.comments.flat_map do |comment|
          comment.split /\s+/
        end
      end
    end
  end
end



def words_in_list_bind(blogs)
  Monadist::List.unit(blogs).
    bind { |blog| Monadist::List.unit blog.categories }.
    bind { |category| Monadist::List.unit category.posts }.
    bind { |post| Monadist::List.unit post.comments }.
    bind { |comment| Monadist::List.unit comment.split /\s+/ }.
    values
end



def words_in_list_fmap(blogs)
  Monadist::List.unit(blogs).
    fmap { |blog| blog.categories }.
    fmap { |category| category.posts }.
    fmap { |post| post.comments }.
    fmap { |comment| comment.split /\s+/ }.
    values
end



def words_in_list_sugar(blogs)
  list(blogs).categories.posts.comments.split(/\s+/).values
end



blogs = [
  Blog.new([Category.new([Post.new(['I love cats', 'I love dogs']),
                          Post.new(['I love mice', 'I love pigs'])]),
            Category.new([Post.new(['I hate cats', 'I hate dogs']),
                          Post.new(['I hate mice', 'I hate pigs'])])]),

  Blog.new([Category.new([Post.new(['Red is better than blue'])]),
            Category.new([Post.new(['Blue is better than red'])])])
]

p words_in(blogs)
p words_in_list_bind(blogs)
p words_in_list_fmap(blogs)
p words_in_list_sugar(blogs)
