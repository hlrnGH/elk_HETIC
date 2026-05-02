console.log("START");

const express = require("express");
const { Client } = require("@elastic/elasticsearch");
const cors = require("cors");

const app = express();
app.use(cors());

// Connexion Elasticsearch
//const client = new Client({
//  node: "http://localhost:9200",
//}); VERSION INCOMPATIBLE j'ai rajouté le true + npm install @elastic/elasticsearch@8 dans le terminal
const client = new Client({
  node: "http://localhost:9200",
  compatibility: true
});

// Route recherche
app.get("/search", async (req, res) => {
  const { q, lang } = req.query;

  try {
    const response = await client.search({
      index: "movies_clean",
      body: {
        query: {
          bool: {
            must: q
              ? [
                  {
                    multi_match: {
                      query: q,
                      fields: ["title", "overview"],
                    },
                  },
                ]
              : [{ match_all: {} }],
            filter: lang
              ? [{ term: { original_language: lang } }]
              : [],
          },
        },
      },
    });

//    res.json(response.hits.hits.map((hit) => hit._source)); resultat tres moche 
res.json(

  response.hits.hits.map((hit) => ({

    title: hit._source.title,

    year: hit._source.release_date?.split("T")[0],

    rating: hit._source.vote_average

  }))

);

  } catch (error) {
    console.error("ERREUR ELASTIC:", error);
    res.status(500).send("Erreur Elasticsearch");
  }
});

// Lancement serveur
app.listen(3000, () => {
  console.log("API running on http://localhost:3000");
});