defmodule Helpcenter.KnowledgeBase.Category do
  use Ash.Resource, domain: Helpcenter.KnowledgeBase, data_layer: AshPostgres.DataLayer

  postgres do
    table "categories"
    repo Helpcenter.Repo

    references do
      reference :articles, on_delete: :delete
    end
  end

  actions do
    default_accept [:name, :slug, :description]
    defaults [:create, :read, :update, :destroy]

    update :create_article do
      description "Create an article under a specified category."
      require_atomic? false
      argument :article_attrs, :map, allow_nil?: false
      change manage_relationship(:article_attrs, :articles, type: :create)
    end

    create :create_with_article do
      description "Create a Category and an article under it"
      argument :article_attrs, :map, allow_nil?: false
      change manage_relationship(:article_attrs, :articles, type: :create)
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
    attribute :slug, :string
    attribute :description, :string, allow_nil?: true
    timestamps()
  end

  relationships do
    has_many :articles, Helpcenter.KnowledgeBase.Article do
      description "Relationship with the articles."
      destination_attribute :category_id
    end
  end
end
