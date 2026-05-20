/*
## Search 1 — “How do vector indexes work?”

### What came back? Does it make sense?
The results returned information about vector databases, embeddings, and similarity search. 
This makes sense because the question is directly related to the article, so the search found relevant info.

## Search 2 — “fast similarity search at scale”

### Did it find relevant content even though those exact words aren't in the article?
Yes, the results still talked about HNSW implementations, vector databases, and feature vectors, which are related to 
fast similarity search. This shows that vector search understands meaning, not just exact words.

## Search 3 — “how to make pasta”

### What score did you get? Is it high or low? Why?
The scores were around 0.91–0.92, which is very close to 1.0 because the question was unrelated. 
I think the scores didn't end up reaching 1.0 because vector search still tries to find the
closest semantic meaning possible, even when the topic does not really match the article.
*/