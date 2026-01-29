# Use the official .NET SDK image to build and publish the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY VantagePoint.Api/*.csproj ./VantagePoint.Api/
RUN dotnet restore ./VantagePoint.Api/VantagePoint.Api.csproj
COPY . .
WORKDIR /src/VantagePoint.Api
RUN dotnet publish -c Release -o /app

# Use the official ASP.NET runtime image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "VantagePoint.Api.dll"]
