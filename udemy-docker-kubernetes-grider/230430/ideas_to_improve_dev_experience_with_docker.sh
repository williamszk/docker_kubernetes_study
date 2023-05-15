
# ============================================================#
# Ideas to improve dev experimence with docker
# ============================================================#

# -------------------------------------------------------------
# In react we can use volumes to map the node_modules and the
# host dir with the src code
# and the engine that builds the page runs inside the container
#
# -------------------------------------------------------------
# 
# -------------------------------------------------------------
# How to run react tests and have automatic updates?
# 
# One idea to run the tests and automatically refresh is to do 
# docker exec -it
# to get into the container and there keep running tests

docker exec -it <container_id> npm run test

