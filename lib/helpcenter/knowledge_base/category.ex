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
