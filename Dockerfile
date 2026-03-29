FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app
COPY . .
RUN dotnet restore "Zamboni.Server/Zamboni.Server.csproj"
RUN dotnet publish "Zamboni.Server/Zamboni.Server.csproj" -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "Zamboni.Server.dll"]
