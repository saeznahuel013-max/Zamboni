FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .

# El comando ahora busca el archivo donde realmente está
RUN dotnet restore "Zamboni.Server/Zamboni.Server.csproj"
RUN dotnet publish "Zamboni.Server/Zamboni.Server.csproj" -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Importante: el nombre de la DLL debe ser el correcto
ENTRYPOINT ["dotnet", "Zamboni.Server.dll"]
