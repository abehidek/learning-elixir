FROM elixir:latest

# Set exposed ports
EXPOSE 5000
ENV PORT=5000 MIX_ENV=prod


RUN mix local.hex --force
RUN mix local.rebar --force

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Same with npm deps
# ADD assets/package.json assets/
# RUN cd assets && \
#     npm install
# 
ADD . .

# Run frontend build, compile, and digest assets
# RUN cd assets/ && \
    # npm run deploy && \
    # cd - && \
RUN mix do compile, phx.digest

CMD ["mix", "phx.server"]