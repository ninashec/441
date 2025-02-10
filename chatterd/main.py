from contextlib import asynccontextmanager
import handlers
from psycopg_pool import AsyncConnectionPool
from starlette.applications import Starlette
from starlette.routing import Route

@asynccontextmanager
async def lifespan(server):
    server.pool = AsyncConnectionPool("dbname=chatterdb user=chatter password=chattchatt host=localhost", open=False)
    await server.pool.open()
    yield
    await server.pool.close()

routes = [
    Route('/getchatts/', handlers.getchatts, methods=['GET']),
    Route('/postchatt/', handlers.postchatt, methods=['POST']),]
    Route('/getaudio/', handlers.getaudio, methods=['GET']),
    Route('/postaudio/', handlers.postaudio, methods=['POST']),
server = Starlette(routes=routes, lifespan=lifespan)
