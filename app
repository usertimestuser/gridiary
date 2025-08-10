<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title></title>
	<meta name="generator" content="LibreOffice 24.8.1.2 (Linux)"/>
	<meta name="created" content="00:00:00"/>
	<meta name="changed" content="00:00:00"/>
	<style type="text/css">
		@page { size: 8.27in 11.69in; margin: 0.79in }
		p { line-height: 115%; margin-bottom: 0.1in; background: transparent }
		pre { background: transparent }
		pre.western { font-family: "Liberation Mono", monospace; font-size: 10pt }
		pre.cjk { font-family: "NSimSun", monospace; font-size: 10pt }
		pre.ctl { font-family: "Liberation Mono", monospace; font-size: 10pt }
	</style>
</head>
<body lang="en-US" link="#000080" vlink="#800000" dir="ltr"><pre class="western">&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
    &lt;meta charset=&quot;UTF-8&quot;&gt;
    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;
    &lt;title&gt;Gridiary: A City Builder Game&lt;/title&gt;
    &lt;!-- Tailwind CSS for modern styling and responsiveness --&gt;
    &lt;script src=&quot;https://cdn.tailwindcss.com&quot;&gt;&lt;/script&gt;
    &lt;link href=&quot;https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&amp;display=swap&quot; rel=&quot;stylesheet&quot;&gt;
    &lt;style&gt;
        body {
            font-family: 'Inter', sans-serif;
            background-color: #e2e8f0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 1rem;
            transition: background-color 1s ease-in-out;
            position: relative; /* Needed for the version text positioning */
            flex-direction: column;
        }

        #game-container {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
            max-width: 1200px;
            width: 100%;
        }

        @media (min-width: 1024px) {
            #game-container {
                grid-template-columns: 1fr 300px;
            }
        }

        #canvas-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #fff;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        canvas {
            background-color: #0c1524;
            border: 2px solid #334155;
            border-radius: 0.5rem;
            cursor: pointer;
            touch-action: none;
            width: 100%;
            height: auto;
            max-width: 800px;
            transition: background-color 1s ease-in-out;
        }

        #ui-panel {
            background-color: #fff;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .stat-card {
            background-color: #f1f5f9;
            border-radius: 0.75rem;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 600;
        }

        .stat-card span:first-child {
            color: #4b5563;
        }

        .stat-card span:last-child {
            color: #1e293b;
        }

        .building-menu {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
            gap: 0.5rem;
        }

        .building-button {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 0.75rem;
            border-radius: 0.75rem;
            background-color: #f1f5f9;
            color: #1e293b;
            font-size: 0.875rem;
            font-weight: 600;
            border: 2px solid transparent;
            transition: all 0.2s ease-in-out;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .building-button:hover:not([disabled]) {
            background-color: #e2e8f0;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        .building-button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            background-color: #cbd5e1;
        }

        .building-button.selected {
            background-color: #3b82f6;
            color: #fff;
            border-color: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 4-6px -1px rgba(59, 130, 246, 0.3), 0 2px 4px -1px rgba(59, 130, 246, 0.2);
        }

        #action-buttons {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .action-button {
            padding: 0.75rem 1.5rem;
            border-radius: 0.75rem;
            font-weight: 700;
            transition: all 0.2s ease-in-out;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        
        #clear-button {
            background-color: #ef4444;
            color: #fff;
        }

        #clear-button:hover {
            background-color: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(239, 68, 68, 0.3);
        }

        #delete-button {
            background-color: #f59e0b;
            color: #fff;
        }

        #delete-button.selected {
            background-color: #d97706;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(245, 158, 11, 0.3);
        }

        #delete-button:hover {
            background-color: #d97706;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(245, 158, 11, 0.3);
        }

        #message-box {
            position: fixed;
            top: 1rem;
            left: 50%;
            transform: translateX(-50%);
            background-color: #333;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
            z-index: 100;
        }
        
        .weather-button {
            padding: 0.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            background-color: #60a5fa;
            color: white;
            transition: background-color 0.2s ease-in-out;
        }

        .weather-button:hover {
            background-color: #3b82f6;
        }
        
        #command-input {
            width: 100%;
            padding: 0.75rem;
            border-radius: 0.75rem;
            border: 2px solid #cbd5e1;
            background-color: #f1f5f9;
            color: #1e293b;
            font-weight: 500;
            transition: border-color 0.2s ease-in-out;
        }

        #command-input:focus {
            outline: none;
            border-color: #3b82f6;
        }
        
        /* New styles for the tooltip */
        #building-tooltip {
            position: absolute;
            background-color: rgba(0, 0, 0, 0.75);
            color: white;
            padding: 0.5rem 0.75rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            white-space: nowrap;
            pointer-events: none; /* Allows mouse events to pass through */
            z-index: 1000;
            opacity: 0;
            transition: opacity 0.2s ease-in-out;
        }
    &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;bg-slate-200&quot;&gt;

    &lt;div id=&quot;game-container&quot; class=&quot;lg:grid-cols-[1fr_300px]&quot;&gt;

        &lt;div id=&quot;canvas-container&quot;&gt;
            &lt;!-- Add a clickable title --&gt;
            &lt;h1 id=&quot;game-title&quot; class=&quot;text-3xl font-bold text-slate-800 mb-2 cursor-pointer&quot;&gt;Gridiary&lt;/h1&gt;
            &lt;h2 class=&quot;text-xl font-semibold text-slate-500 text-center mb-6&quot;&gt;A citybuilder made by Gemini 2.5&lt;/h2&gt;
            &lt;canvas id=&quot;gameCanvas&quot;&gt;&lt;/canvas&gt;
        &lt;/div&gt;

        &lt;div id=&quot;ui-panel&quot;&gt;
            &lt;!-- Stats Panel --&gt;
            &lt;div class=&quot;stats-panel flex flex-col gap-2&quot;&gt;
                &lt;h2 class=&quot;text-xl font-bold text-slate-800&quot;&gt;City Stats&lt;/h2&gt;
                &lt;div class=&quot;grid grid-cols-2 gap-2&quot;&gt;
                    &lt;div class=&quot;stat-card&quot;&gt;
                        &lt;span&gt;ð¥ Population:&lt;/span&gt;
                        &lt;span id=&quot;population-stat&quot;&gt;0&lt;/span&gt;
                    &lt;/div&gt;
                    &lt;div class=&quot;stat-card&quot;&gt;
                        &lt;span&gt;ð° Money:&lt;/span&gt;
                        &lt;span id=&quot;money-stat&quot;&gt;0&lt;/span&gt;
                    &lt;/div&gt;
                    &lt;div class=&quot;stat-card&quot;&gt;
                        &lt;span&gt;â¡ Power:&lt;/span&gt;
                        &lt;span id=&quot;power-stat&quot;&gt;0&lt;/span&gt;
                    &lt;/div&gt;
                    &lt;!-- New Happiness Stat with dynamic emoji --&gt;
                    &lt;div class=&quot;stat-card&quot;&gt;
                        &lt;span&gt;&lt;span id=&quot;happiness-emoji&quot;&gt;ð&lt;/span&gt; Happiness:&lt;/span&gt;
                        &lt;span id=&quot;happiness-stat&quot;&gt;0&lt;/span&gt;
                    &lt;/div&gt;
                    &lt;!-- New Weather Stat --&gt;
                    &lt;div class=&quot;stat-card col-span-2&quot;&gt;
                        &lt;span&gt;Weather:&lt;/span&gt;
                        &lt;span id=&quot;weather-stat&quot;&gt;âï¸ Sunny&lt;/span&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;

            &lt;!-- Building Menu --&gt;
            &lt;div class=&quot;building-selection-panel&quot;&gt;
                &lt;h2 class=&quot;text-xl font-bold text-slate-800 mb-4&quot;&gt;Buildings&lt;/h2&gt;
                &lt;div id=&quot;building-menu&quot; class=&quot;building-menu&quot;&gt;
                    &lt;!-- Buttons will be generated by JavaScript --&gt;
                &lt;/div&gt;
            &lt;/div&gt;

            &lt;!-- Action Buttons --&gt;
            &lt;div id=&quot;action-buttons&quot;&gt;
                &lt;button id=&quot;delete-button&quot; class=&quot;action-button&quot;&gt;Delete Building&lt;/button&gt;
                &lt;button id=&quot;clear-button&quot; class=&quot;action-button&quot;&gt;Clear Grid&lt;/button&gt;
            &lt;/div&gt;
            
            &lt;!-- Weather Control Menu - Initially hidden --&gt;
            &lt;div id=&quot;weather-cheat-panel&quot; class=&quot;hidden&quot;&gt;
                 &lt;h2 class=&quot;text-xl font-bold text-slate-800&quot;&gt;Weather Control&lt;/h2&gt;
                 &lt;div id=&quot;weather-menu&quot; class=&quot;building-menu&quot;&gt;
                     &lt;!-- Weather buttons will be added here dynamically --&gt;
                 &lt;/div&gt;
            &lt;/div&gt;

            &lt;!-- New Command Input Box --&gt;
            &lt;div id=&quot;command-panel&quot; class=&quot;command-panel hidden&quot;&gt;
                &lt;h2 class=&quot;text-xl font-bold text-slate-800&quot;&gt;Command Console&lt;/h2&gt;
                &lt;input type=&quot;text&quot; id=&quot;command-input&quot; placeholder=&quot;Enter commands here...&quot;&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
    
    &lt;!-- Message box for in-game notifications --&gt;
    &lt;div id=&quot;message-box&quot;&gt;&lt;/div&gt;
    
    &lt;!-- Tooltip for building info --&gt;
    &lt;div id=&quot;building-tooltip&quot;&gt;&lt;/div&gt;
    
    &lt;!-- Version text at the bottom --&gt;
    &lt;p class=&quot;mt-8 text-xs text-slate-400&quot;&gt;Version 1.0&lt;/p&gt;

    &lt;script&gt;
        document.addEventListener('DOMContentLoaded', () =&gt; {
            const canvas = document.getElementById('gameCanvas');
            const ctx = canvas.getContext('2d');
            const clearButton = document.getElementById('clear-button');
            const deleteButton = document.getElementById('delete-button');
            const buildingMenu = document.getElementById('building-menu');
            const messageBox = document.getElementById('message-box');
            const weatherStat = document.getElementById('weather-stat');
            const commandInput = document.getElementById('command-input');
            const weatherCheatPanel = document.getElementById('weather-cheat-panel');
            const commandPanel = document.getElementById('command-panel');
            const gameTitle = document.getElementById('game-title');
            const buildingTooltip = document.getElementById('building-tooltip');

            // Game configuration
            const GRID_SIZE = 20;
            const TILE_SIZE = 32; // In pixels, will be adjusted for responsiveness
            const UPDATE_INTERVAL = 2000; // 2 seconds
            const WEATHER_CHANGE_INTERVAL = 120000; // 2 minutes in milliseconds
            const ALTAR_STATE_CHANGE_INTERVAL = 600000; // 10 minutes
            const MAX_HAPPINESS = 100;
            const MONEY_RAIN_POP_UNLOCK = 100;
            const PEOPLE_PER_POPULATION_UNIT = 5;
            
            // New constants for capping icons and adding birds
            const MAX_PEOPLE_ICONS = 30;
            const MAX_BIRDS_ICONS = 3;
            const PERSON_SPEED = 0.5;
            const BIRD_ICON = 'ð¦';
            const BIRD_SPEED = 1;
            // Tornado constants
            const TORNADO_SPEED = 2;
            const TORNADO_GROWTH_RATE = 0.05;
            const MAX_TORNADO_SCALE = 3;
            const TORNADO_POPULATION_LOSS_PER_SECOND = 5;
            const MAX_STAT_VALUE = 100000000000; // New constant for maximum stat values

            // People icons for different weather conditions
            const peopleIcons = {
                'sunny': 'ð¶ââï¸',
                'rain': 'â',
                'night': 'ð¤',
                'money-rain': 'ð¶ââï¸',
                'tornadic': 'ð±'
            };


            let scaledTileSize;

            canvas.width = GRID_SIZE * TILE_SIZE;
            canvas.height = GRID_SIZE * TILE_SIZE;

            // Game state variables
            let money = 500;
            let population = 0;
            let power = 0;
            let happiness = 0;
            let grid = Array.from({ length: GRID_SIZE }, () =&gt; Array(GRID_SIZE).fill(null));
            let selectedBuilding = null;
            let isDeleting = false;
            let hoverPosition = { x: -1, y: -1 };
            
            // Track the state of each individual Altar building
            let activeAltars = [];
            const ALTAR_STATE_POSITIVE = 'positive';
            const ALTAR_STATE_NEGATIVE = 'negative';
            const altarStates = {
                [ALTAR_STATE_POSITIVE]: {
                    name: 'Positive',
                    icon: ' ',
                    passiveProvides: {
                        happiness: 10,
                        money: -5,
                        power: -10
                    }
                },
                [ALTAR_STATE_NEGATIVE]: {
                    name: 'Negative',
                    icon: 'ð',
                    passiveProvides: {
                        money: -10,
                        population: -10,
                        happiness: -10
                    }
                }
            };

            // People and tornado state variables
            let people = [];
            let birds = []; 
            let tornado = null; // New variable for the tornado
            
            // Flag to check if the weather cheat has been unlocked
            let weatherCheatUnlocked = false;

            // Map stat keys to their emojis for display
            const statEmojis = {
                'population': 'ð¥',
                'money': 'ð°',
                'power': 'â¡',
                'happiness': 'ð'
            };
            
            // Map weather states to grid background colors
            const weatherGridBackgrounds = {
                'sunny': '#0c1524',
                'rain': '#1e293b',
                'night': '#0c0c0c',
                'money-rain': '#112211',
                'tornadic': '#1a1a1a'
            };

            // Weather state variables
            let currentWeather = 'sunny';
            const weatherOptions = ['sunny', 'rain', 'night'];
            const advancedWeatherOptions = ['sunny', 'rain', 'night', 'money-rain'];
            const weatherIcons = {
                'sunny': 'âï¸ Sunny',
                'rain': 'ð§ï¸ Rain',
                'night': 'ð Night',
                'money-rain': 'ð¸ Money Rain',
                'tornadic': 'ðªï¸ Tornadic'
            };
            
            // Define all possible weather types for the cheat menu
            const allWeatherOptions = ['sunny', 'rain', 'night', 'money-rain', 'tornadic'];

            // Define building types with their properties
            const buildings = {
                house: {
                    name: 'House',
                    icon: 'ð&nbsp;',
                    cost: 50,
                    size: { width: 1, height: 1 },
                    provides: { population: 5, power: -2 },
                    unlocksAt: 0,
                    description: 'Small housing for ð¥.'
                },
                apartment: {
                    name: 'Apartment',
                    icon: 'ð¢',
                    cost: 150,
                    size: { width: 1, height: 1 },
                    unlocksAt: 100,
                    provides: { population: 20, power: -10 },
                    description: 'Provides more ð¥, costs â¡.'
                },
                shop: {
                    name: 'Shop',
                    icon: 'ðª',
                    cost: 75,
                    size: { width: 1, height: 1 },
                    passiveProvides: { money: 10, power: -5 },
                    unlocksAt: 0,
                    description: 'Generates ð°, consumes â¡.'
                },
                factory: {
                    name: 'Factory',
                    icon: 'ð&shy;',
                    cost: 200,
                    size: { width: 3, height: 3 },
                    unlocksAt: 100,
                    passiveProvides: { money: 100, power: -20 },
                    description: 'Large ð° generator, consumes â¡. 3x3.'
                },
                road: {
                    name: 'Road',
                    icon: 'ð£ï¸',
                    cost: 10,
                    size: { width: 1, height: 1 },
                    passiveProvides: { population: 0.4, money: -4 },
                    unlocksAt: 0,
                    description: 'Boosts ð¥ at a small ð° cost.'
                },
                powerplant: {
                    name: 'Power Plant',
                    icon: 'â¡',
                    cost: 300,
                    size: { width: 1, height: 1 },
                    passiveProvides: { power: 20 },
                    unlocksAt: 0,
                    description: 'Generates a lot of â¡.'
                },
                nuclearplant: {
                    name: 'Nuclear Plant',
                    icon: 'â¢ï¸',
                    cost: 2000,
                    size: { width: 2, height: 2 },
                    unlocksAt: 500,
                    passiveProvides: { power: 50, happiness: -2 },
                    description: 'Massive â¡ generation, but reduces ð. 2x2.'
                },
                park: {
                    name: 'Park',
                    icon: ['ð³', 'ð²'], // Park now has a random icon
                    cost: 20,
                    size: { width: 1, height: 1 },
                    provides: { population: 1 },
                    passiveProvides: { happiness: 0.1 },
                    unlocksAt: 0,
                    description: 'Increases ð¥ and ð.'
                },
                altar: {
                    name: 'Altar',
                    icon: 'ð',
                    cost: 2000,
                    size: { width: 3, height: 3 },
                    unlocksAt: 500,
                    undeletable: true
                },
                skyscraper: {
                    name: 'Skyscraper',
                    icon: 'ðï¸',
                    cost: 500,
                    size: { width: 3, height: 3 },
                    unlocksAt: 150,
                    provides: { population: 1, power: -15 },
                    passiveProvides: { population: 2 },
                    description: 'Generates ð¥ over time. 3x3.'
                },
                aquarium: {
                    name: 'Aquarium',
                    icon: 'ð&nbsp;',
                    cost: 100,
                    size: { width: 1, height: 1 },
                    unlocksAt: 100,
                    provides: { power: -5 },
                    passiveProvides: { happiness: 1 },
                    description: 'A great source of ð, consumes â¡.'
                }
            };

            /**
             * Initializes the game grid with empty tiles.
             */
            function initializeGrid() {
                grid = Array.from({ length: GRID_SIZE }, () =&gt; Array(GRID_SIZE).fill(null));
                activeAltars = []; // Reset altars
            }

            /**
             * Renders the game grid and buildings on the canvas.
             */
            function drawGrid() {
                // Adjust tile size for responsive canvas
                scaledTileSize = canvas.width / GRID_SIZE;
                
                // Clear the canvas and set the dynamic background color for the grid space
                ctx.fillStyle = weatherGridBackgrounds[currentWeather];
                ctx.fillRect(0, 0, canvas.width, canvas.height);
                
                // Set the static grid line color
                ctx.strokeStyle = '#334155';
                
                for (let y = 0; y &lt; GRID_SIZE; y++) {
                    for (let x = 0; x &lt; GRID_SIZE; x++) {
                        // Draw the grid cells
                        ctx.strokeRect(x * scaledTileSize, y * scaledTileSize, scaledTileSize, scaledTileSize);

                        // Draw the building if it exists
                        const buildingTypeKey = grid[y][x];
                        if (buildingTypeKey) {
                            const buildingType = buildings[buildingTypeKey];

                            // Draw a semi-transparent background for the entire building area
                            const drawWidth = buildingType.size.width * scaledTileSize;
                            const drawHeight = buildingType.size.height * scaledTileSize;
                            
                            // To prevent over-drawing for multi-tile buildings, only draw the main rect once at the top-left tile
                            const isTopLeft = (x === 0 || grid[y][x-1] !== buildingTypeKey) &amp;&amp;
                                              (y === 0 || grid[y-1][x] !== buildingTypeKey);
                            if (isTopLeft) {
                                ctx.fillStyle = 'rgba(255, 255, 255, 0.2)';
                                ctx.fillRect(x * scaledTileSize, y * scaledTileSize, drawWidth, drawHeight);
                            }
                            
                            // Draw the building icon on every tile it occupies
                            const icon = Array.isArray(buildingType.icon) ? buildingType.icon[0] : buildingType.icon; // Use the first icon for grid rendering
                            ctx.font = `${scaledTileSize * 0.7}px sans-serif`;
                            ctx.textAlign = 'center';
                            ctx.textBaseline = 'middle';
                            ctx.fillStyle = '#fff';
                            ctx.fillText(icon, x * scaledTileSize + scaledTileSize / 2, y * scaledTileSize + scaledTileSize / 2);
                        }
                    }
                }

                // Draw hover effect for placement or deletion
                if (hoverPosition.x &gt;= 0 &amp;&amp; hoverPosition.y &gt;= 0) {
                    const { x, y } = hoverPosition;
                    
                    if (isDeleting) {
                        const buildingTypeKey = grid[y][x];
                        if (buildingTypeKey) {
                            const buildingType = buildings[buildingTypeKey];
                            const { width, height } = buildingType.size;
                            ctx.fillStyle = 'rgba(255, 100, 100, 0.7)';
                            ctx.fillRect(x * scaledTileSize, y * scaledTileSize, width * scaledTileSize, height * scaledTileSize);
                        }
                    } else if (selectedBuilding) {
                        const buildingType = buildings[selectedBuilding];
                        const { width, height } = buildingType.size;

                        let canPlace = true;
                        // Check all tiles for the building size
                        for (let j = 0; j &lt; height; j++) {
                            for (let i = 0; i &lt; width; i++) {
                                if (x + i &gt;= GRID_SIZE || y + j &gt;= GRID_SIZE || grid[y + j][x + i] !== null) {
                                    canPlace = false;
                                    break;
                                }
                            }
                            if (!canPlace) break;
                        }
                        
                        // Draw the hover effect based on placement validity
                        if (canPlace) {
                            ctx.fillStyle = 'rgba(100, 200, 255, 0.5)';
                            ctx.fillRect(x * scaledTileSize, y * scaledTileSize, width * scaledTileSize, height * scaledTileSize);
                            ctx.strokeStyle = 'rgba(100, 200, 255, 0.8)';
                            ctx.lineWidth = 2;
                            ctx.strokeRect(x * scaledTileSize, y * scaledTileSize, width * scaledTileSize, height * scaledTileSize);
                        } else {
                            // Show a red hover if the tile is occupied or out of bounds
                            ctx.fillStyle = 'rgba(255, 100, 100, 0.5)';
                            ctx.fillRect(x * scaledTileSize, y * scaledTileSize, width * scaledTileSize, height * scaledTileSize);
                        }
                    }
                }
            }

            /**
             * Places a building on the grid at a specific position.
             * @param {number} x - The x-coordinate of the grid.
             * @param {number} y - The y-coordinate of the grid.
             */
            function placeBuilding(x, y) {
                if (!selectedBuilding) {
                    showMessage('Please select a building first.');
                    return;
                }

                const buildingType = buildings[selectedBuilding];
                const { width, height } = buildingType.size;

                // Check for grid boundaries and existing buildings
                for (let j = 0; j &lt; height; j++) {
                    for (let i = 0; i &lt; width; i++) {
                        if (x + i &gt;= GRID_SIZE || y + j &gt;= GRID_SIZE || grid[y + j][x + i] !== null) {
                            showMessage('Cannot place building here. Area is occupied or out of bounds.');
                            return;
                        }
                    }
                }
                
                // Check population unlock requirement
                if (buildingType.unlocksAt &amp;&amp; population &lt; buildingType.unlocksAt) {
                    showMessage(`Population must be at least ${buildingType.unlocksAt} to build this.`);
                    return;
                }

                if (money &gt;= buildingType.cost) {
                    money -= buildingType.cost;
                    
                    // Place the building across all required tiles
                    for (let j = 0; j &lt; height; j++) {
                        for (let i = 0; i &lt; width; i++) {
                            grid[y + j][x + i] = selectedBuilding;
                        }
                    }

                    showMessage(`${buildingType.name} placed!`);

                    // Apply one-time effects immediately on placement
                    if (buildingType.provides &amp;&amp; buildingType.provides.population) population += buildingType.provides.population;
                    if (buildingType.provides &amp;&amp; buildingType.provides.money) money += buildingType.provides.money;
                    if (buildingType.provides &amp;&amp; buildingType.provides.power) power += buildingType.provides.power;
                    
                    // Handle special case for altar
                    if (selectedBuilding === 'altar') {
                        const randomState = Math.random() &lt; 0.5 ? ALTAR_STATE_POSITIVE : ALTAR_STATE_NEGATIVE;
                        activeAltars.push({x, y, state: randomState});
                        showMessage(`An Altar has been built! It is currently in a ${altarStates[randomState].name} state.`);
                    }

                } else {
                    showMessage('Not enough money!');
                }
                updateStats();
                drawGrid();
            }

            /**
             * Deletes a building from the grid at a specific position.
             * @param {number} x - The x-coordinate of the grid.
             * @param {number} y - The y-coordinate of the grid.
             */
            function deleteBuilding(x, y) {
                const buildingTypeKey = grid[y][x];
                if (!buildingTypeKey) {
                    showMessage('No building to delete here.');
                    return;
                }
                
                const buildingType = buildings[buildingTypeKey];
                
                // Prevent deletion of undeletable buildings, like the altar
                if (buildingType.undeletable) {
                    showMessage(`The ${buildingType.name} is a permanent structure and cannot be deleted.`);
                    return;
                }

                const { width, height } = buildingType.size;

                // Find the top-left corner of the multi-tile building
                let startX = x;
                let startY = y;
                while (startX &gt; 0 &amp;&amp; grid[y][startX - 1] === buildingTypeKey) {
                    startX--;
                }
                while (startY &gt; 0 &amp;&amp; grid[startY - 1][x] === buildingTypeKey) {
                    startY--;
                }

                // Remove all tiles of the building
                for (let j = 0; j &lt; height; j++) {
                    for (let i = 0; i &lt; width; i++) {
                        if (grid[startY + j] &amp;&amp; grid[startY + j][startX + i] === buildingTypeKey) {
                             grid[startY + j][startX + i] = null;
                        }
                    }
                }

                // Refund half the cost
                money += buildingType.cost / 2;
                showMessage(`${buildingType.name} deleted. Refunded $${buildingType.cost / 2}.`);
                
                // One-time effects are reversed
                if (buildingType.provides) {
                    if (buildingType.provides.population) population -= buildingType.provides.population;
                    if (buildingType.provides.money) money -= buildingType.provides.money;
                    if (buildingType.provides.power) power -= buildingType.provides.power;
                }
                
                // Remove altar from activeAltars list if applicable
                if (buildingTypeKey === 'altar') {
                    activeAltars = activeAltars.filter(altar =&gt; altar.x !== startX || altar.y !== startY);
                }

                updateStats();
                drawGrid();
            }
            
            /**
             * Formats a number with K, M, and B prefixes for thousands, millions, and billions.
             * @param {number} value - The number to format.
             * @returns {string} The formatted string.
             */
            function formatStatValue(value) {
                if (Math.abs(value) &gt;= 1000000000) {
                    return (value / 1000000000).toFixed(1) + 'B';
                }
                if (Math.abs(value) &gt;= 1000000) {
                    return (value / 1000000).toFixed(1) + 'M';
                }
                if (Math.abs(value) &gt;= 1000) {
                    return (value / 1000).toFixed(1) + 'K';
                }
                return Math.floor(value).toString();
            }

            /**
             * Updates the city's stats (population, money, power, happiness) based on buildings.
             * This function now also handles passive stat changes over time and weather effects.
             */
            function updateStats() {
                let passivePopulation = 0;
                let passiveMoney = 0;
                let passivePower = 0;
                let passiveHappiness = 0;
                
                // Calculate passive effects from all buildings except altars
                grid.forEach(row =&gt; {
                    row.forEach(cell =&gt; {
                        if (cell &amp;&amp; buildings[cell].passiveProvides) {
                            const building = buildings[cell];
                            if (building.passiveProvides.population) passivePopulation += building.passiveProvides.population;
                            if (building.passiveProvides.money) passiveMoney += building.passiveProvides.money;
                            if (building.passiveProvides.power) passivePower += building.passiveProvides.power;
                            if (building.passiveProvides.happiness) passiveHappiness += building.passiveProvides.happiness;
                        }
                    });
                });
                
                // Add passive effects from active altars
                activeAltars.forEach(altar =&gt; {
                    const stateEffects = altarStates[altar.state].passiveProvides;
                    if (stateEffects) {
                        if (stateEffects.population) passivePopulation += stateEffects.population;
                        if (stateEffects.money) passiveMoney += stateEffects.money;
                        if (stateEffects.power) passivePower += stateEffects.power;
                        if (stateEffects.happiness) passiveHappiness += stateEffects.happiness;
                    }
                });

                // Apply weather effects
                const intervalSeconds = UPDATE_INTERVAL / 1000;

                if (currentWeather === 'night') {
                    // Halve monetary gain
                    passiveMoney *= 0.5;
                } else if (currentWeather === 'money-rain') {
                    // Only double positive monetary gain
                    if (passiveMoney &gt; 0) {
                        passiveMoney *= 2;
                    }
                } else if (currentWeather === 'tornadic') {
                    population -= TORNADO_POPULATION_LOSS_PER_SECOND * intervalSeconds;
                }

                
                // Update stats based on passive changes (multiplied by interval time)
                money += passiveMoney * intervalSeconds;
                population += passivePopulation * intervalSeconds;
                power += passivePower * intervalSeconds;
                happiness += passiveHappiness * intervalSeconds;

                // Clamp all stats to their maximum and minimum values
                if (money &gt; MAX_STAT_VALUE) money = MAX_STAT_VALUE;
                if (population &gt; MAX_STAT_VALUE) population = MAX_STAT_VALUE;
                if (power &gt; MAX_STAT_VALUE) power = MAX_STAT_VALUE;
                
                // Prevent population from going into negative
                if (population &lt; 0) {
                    population = 0;
                }
                
                // Clamp happiness to a maximum of 100
                if (happiness &gt; MAX_HAPPINESS) {
                    happiness = MAX_HAPPINESS;
                }
                // Clamp happiness to a minimum of 0
                if (happiness &lt; 0) {
                    happiness = 0;
                }

                // Update the UI
                document.getElementById('population-stat').textContent = formatStatValue(population);
                document.getElementById('money-stat').textContent = formatStatValue(money);
                document.getElementById('power-stat').textContent = formatStatValue(power);

                // **New: Update the happiness emoji based on the happiness value**
                const happinessEmojiSpan = document.getElementById('happiness-emoji');
                if (happiness &lt;= 0) {
                    happinessEmojiSpan.textContent = 'ð¢';
                } else if (happiness &gt;= 100) {
                    happinessEmojiSpan.textContent = 'ð';
                } else {
                    happinessEmojiSpan.textContent = 'ð';
                }
                document.getElementById('happiness-stat').textContent = formatStatValue(happiness);

                // Simple game over condition
                if (power &lt; 0) {
                    showMessage('Warning: Power shortage! Your city is suffering.');
                }
                
                // Re-generate the building menu to update locked/unlocked states
                generateBuildingMenu();
                // Update the number of people on the grid
                updatePeopleCount();
                // Update the number of birds on the grid
                updateBirdCount();
            }
            
            /**
             * Changes the weather to a new random state or a specific one from the cheat menu.
             */
            function changeWeather(newWeather = null) {
                if (newWeather) {
                    currentWeather = newWeather;
                } else {
                    const hasPositiveAltar = activeAltars.some(altar =&gt; altar.state === ALTAR_STATE_POSITIVE);
                    const hasNegativeAltar = activeAltars.some(altar =&gt; altar.state === ALTAR_STATE_NEGATIVE);
                    
                    // Determine which weather options are available
                    let availableWeather = ['sunny', 'rain', 'night'];
                    if (hasPositiveAltar &amp;&amp; population &gt;= MONEY_RAIN_POP_UNLOCK) {
                        availableWeather.push('money-rain');
                    }
                    if (hasNegativeAltar) {
                        availableWeather.push('tornadic');
                    }
                    
                    // Get a random weather state, excluding the current one
                    const filteredWeather = availableWeather.filter(w =&gt; w !== currentWeather);
                    if (filteredWeather.length &gt; 0) {
                        currentWeather = filteredWeather[Math.floor(Math.random() * filteredWeather.length)];
                    } else {
                        // Default to sunny if no other options are available (e.g. no altars)
                        currentWeather = 'sunny';
                    }
                }
                
                // If the new weather is tornadic, initialize the tornado
                if (currentWeather === 'tornadic') {
                    tornado = {
                        x: Math.random() * canvas.width,
                        y: Math.random() * canvas.height,
                        vx: (Math.random() - 0.5) * TORNADO_SPEED,
                        vy: (Math.random() - 0.5) * TORNADO_SPEED,
                        scale: 1
                    };
                } else {
                    tornado = null; // Clear the tornado when weather changes
                }

                // Update the UI and show a message
                weatherStat.textContent = weatherIcons[currentWeather];
                showMessage(`Weather changed to ${weatherIcons[currentWeather]}!`);
                
                // Update GUI color and redraw grid to reflect change
                updateGuiColor();
                drawGrid();
            }
            
            /**
             * Randomly changes the state of all active altars.
             */
            function changeAltarStates() {
                if (activeAltars.length &gt; 0) {
                    activeAltars.forEach(altar =&gt; {
                        const newState = Math.random() &lt; 0.5 ? ALTAR_STATE_POSITIVE : ALTAR_STATE_NEGATIVE;
                        if (altar.state !== newState) {
                            altar.state = newState;
                            showMessage(`An Altar has changed to a ${altarStates[newState].name} state!`);
                        }
                    });
                }
            }

            /**
             * Updates the GUI color based on the current weather.
             */
            function updateGuiColor() {
                const body = document.body;
                switch (currentWeather) {
                    case 'sunny':
                        body.style.backgroundColor = '#fefcbf';
                        break;
                    case 'rain':
                        body.style.backgroundColor = '#bfd8ff';
                        break;
                    case 'night':
                        body.style.backgroundColor = '#0c1524';
                        break;
                    case 'money-rain':
                        body.style.backgroundColor = '#bbf7d0';
                        break;
                    case 'tornadic':
                        body.style.backgroundColor = '#1a1a1a';
                        break;
                    default:
                        body.style.backgroundColor = '#e2e8f0';
                }
            }

            /**
             * Generates the building selection buttons dynamically, sorted by population requirement.
             */
            function generateBuildingMenu() {
                // Clear existing buttons first
                buildingMenu.innerHTML = '';
                
                // Convert buildings object to an array to sort it
                const buildingsArray = Object.keys(buildings).map(key =&gt; ({
                    ...buildings[key],
                    key: key, // Add key to the object for easy access
                    unlocksAt: buildings[key].unlocksAt || 0 // Default to 0 if not specified
                }));
                
                // Sort the buildings by the unlocksAt property
                buildingsArray.sort((a, b) =&gt; a.unlocksAt - b.unlocksAt);

                buildingsArray.forEach(building =&gt; {
                    // Do not show the building button if population requirement is not met
                    if (building.unlocksAt &amp;&amp; population &lt; building.unlocksAt) {
                        return; // Skip this iteration
                    }
                    
                    const button = document.createElement('button');
                    button.className = 'building-button';
                    
                    let passiveText = '';
                    
                    // Only show passive effects for buildings that are NOT the altar
                    if (building.key !== 'altar' &amp;&amp; building.passiveProvides) {
                        for (const stat in building.passiveProvides) {
                            const value = building.passiveProvides[stat];
                            if (value !== 0) {
                                passiveText += `${value &gt; 0 ? '+' : ''}${value} ${statEmojis[stat]}/s `;
                            }
                        }
                    }

                    // Handle dynamic park icon
                    const icon = Array.isArray(building.icon) ? building.icon[Math.floor(Math.random() * building.icon.length)] : building.icon;

                    button.innerHTML = `
                        &lt;span class=&quot;building-icon&quot;&gt;${icon}&lt;/span&gt;
                        &lt;span&gt;${building.name} ($${building.cost})&lt;/span&gt;
                        ${passiveText ? `&lt;span class=&quot;text-xs mt-1 text-slate-500&quot;&gt;${passiveText.trim()}&lt;/span&gt;` : ''}
                    `;
                    
                    // If there's a description, add a tooltip-like effect
                    if (building.description) {
                         const descriptionSpan = document.createElement('span');
                         descriptionSpan.className = 'text-xs mt-1 text-slate-500';
                         descriptionSpan.textContent = building.description;
                         button.appendChild(descriptionSpan);
                    }
                    
                    button.onclick = () =&gt; {
                        // Deselect other buttons and deletion mode
                        document.querySelectorAll('.building-button').forEach(btn =&gt; btn.classList.remove('selected'));
                        deleteButton.classList.remove('selected');
                        isDeleting = false;
                        
                        if (selectedBuilding === building.key) {
                            selectedBuilding = null; // Toggle off if already selected
                        } else {
                            selectedBuilding = building.key;
                            button.classList.add('selected');
                        }
                    };
                    buildingMenu.appendChild(button);
                });
            }

            /**
             * Displays a temporary message to the user.
             * @param {string} message - The message to display.
             */
            function showMessage(message) {
                messageBox.textContent = message;
                messageBox.style.opacity = 1;
                setTimeout(() =&gt; {
                    messageBox.style.opacity = 0;
                }, 2000);
            }

            /**
             * Updates the number of 'people' icons on the canvas based on the population stat.
             */
            function updatePeopleCount() {
                const targetPeopleCount = Math.floor(population / PEOPLE_PER_POPULATION_UNIT);
                const cappedPeopleCount = Math.min(targetPeopleCount, MAX_PEOPLE_ICONS);

                if (people.length &lt; cappedPeopleCount) {
                    for (let i = people.length; i &lt; cappedPeopleCount; i++) {
                        people.push({
                            x: Math.random() * canvas.width,
                            y: Math.random() * canvas.height,
                            vx: (Math.random() - 0.5) * PERSON_SPEED,
                            vy: (Math.random() - 0.5) * PERSON_SPEED
                        });
                    }
                } else if (people.length &gt; cappedPeopleCount) {
                    people.splice(cappedPeopleCount);
                }
            }

            /**
             * Updates the number of 'bird' icons on the canvas based on the number of parks.
             */
            function updateBirdCount() {
                // Count the number of parks on the grid
                let parkCount = 0;
                grid.forEach(row =&gt; {
                    row.forEach(cell =&gt; {
                        if (cell === 'park') {
                            parkCount++;
                        }
                    });
                });

                // Cap the number of birds based on the park count and max birds constant
                const targetBirdCount = Math.min(parkCount, MAX_BIRDS_ICONS);

                if (birds.length &lt; targetBirdCount) {
                    for (let i = birds.length; i &lt; targetBirdCount; i++) {
                        birds.push({
                            x: Math.random() * canvas.width,
                            y: Math.random() * canvas.height,
                            vx: (Math.random() - 0.5) * BIRD_SPEED * 2,
                            vy: (Math.random() - 0.5) * BIRD_SPEED * 2
                        });
                    }
                } else if (birds.length &gt; targetBirdCount) {
                    birds.splice(targetBirdCount);
                }
            }


            /**
             * Moves the people around the screen based on weather conditions.
             */
            function updatePeople() {
                let currentSpeed = PERSON_SPEED;
                switch (currentWeather) {
                    case 'night':
                        currentSpeed = 0; // People stand still
                        break;
                    case 'money-rain':
                        currentSpeed *= 2; // People move twice as fast
                        break;
                    case 'tornadic':
                         currentSpeed *= 2; // People move twice as fast to escape
                         break;
                    default:
                        // Sunny and rain have normal speed
                        currentSpeed = PERSON_SPEED;
                        break;
                }

                people.forEach(person =&gt; {
                    person.x += person.vx * currentSpeed;
                    person.y += person.vy * currentSpeed;

                    // Reverse direction if a person hits the canvas edge, unless they are standing still
                    if (currentSpeed &gt; 0) {
                        if (person.x &lt; 0 || person.x &gt; canvas.width) {
                            person.vx *= -1;
                        }
                        if (person.y &lt; 0 || person.y &gt; canvas.height) {
                            person.vy *= -1;
                        }
                    }
                });
            }

            /**
             * Draws the moving people icons on the canvas.
             */
            function drawPeople() {
                ctx.font = '16px sans-serif';
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                const icon = peopleIcons[currentWeather];
                people.forEach(person =&gt; {
                    ctx.fillText(icon, person.x, person.y);
                });
            }
            
            /**
             * Moves the bird icons around the screen.
             */
            function updateBirds() {
                birds.forEach(bird =&gt; {
                    bird.x += bird.vx;
                    bird.y += bird.vy;

                    // Reverse direction if a bird hits the canvas edge
                    if (bird.x &lt; 0 || bird.x &gt; canvas.width) {
                        bird.vx *= -1;
                    }
                    if (bird.y &lt; 0 || bird.y &gt; canvas.height) {
                        bird.vy *= -1;
                    }
                });
            }
            
            /**
             * Draws the moving bird icons on the canvas.
             */
            function drawBirds() {
                ctx.font = '16px sans-serif';
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                birds.forEach(bird =&gt; {
                    ctx.fillText(BIRD_ICON, bird.x, bird.y);
                });
            }

            /**
             * Moves and scales the tornado, and checks for building collisions.
             */
            function updateTornado() {
                if (!tornado) return;
                
                // Move the tornado
                tornado.x += tornado.vx;
                tornado.y += tornado.vy;

                // Reverse direction if the tornado hits the canvas edge
                if (tornado.x &lt; 0 || tornado.x &gt; canvas.width) {
                    tornado.vx *= -1;
                }
                if (tornado.y &lt; 0 || tornado.y &gt; canvas.height) {
                    tornado.vy *= -1;
                }

                // Grow the tornado
                if (tornado.scale &lt; MAX_TORNADO_SCALE) {
                    tornado.scale += TORNADO_GROWTH_RATE;
                }
                
                // --- NEW TORNADO DESTRUCTION LOGIC ---
                // Convert tornado's canvas position to grid coordinates
                const tornadoGridX = Math.floor(tornado.x / scaledTileSize);
                const tornadoGridY = Math.floor(tornado.y / scaledTileSize);
                
                // Check a 3x3 square around the tornado's center
                let destroyed = false;
                for (let y = tornadoGridY - 1; y &lt;= tornadoGridY + 1 &amp;&amp; !destroyed; y++) {
                    for (let x = tornadoGridX - 1; x &lt;= tornadoGridX + 1 &amp;&amp; !destroyed; x++) {
                        // Ensure coordinates are within grid bounds
                        if (x &gt;= 0 &amp;&amp; x &lt; GRID_SIZE &amp;&amp; y &gt;= 0 &amp;&amp; y &lt; GRID_SIZE) {
                            const buildingTypeKey = grid[y][x];
                            if (buildingTypeKey) {
                                const buildingType = buildings[buildingTypeKey];
                                if (!buildingType.undeletable) {
                                    deleteBuilding(x, y);
                                    showMessage(`A ${buildingType.name} was destroyed by the tornado!`);
                                    tornado.vx *= -1;
                                    tornado.vy *= -1;
                                    destroyed = true;
                                }
                            }
                        }
                    }
                }
            }
             
            /**
             * Draws the tornado icon on the canvas.
             */
            function drawTornado() {
                if (!tornado) return;
                
                ctx.font = `${scaledTileSize * 0.7 * tornado.scale}px sans-serif`;
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                ctx.fillText('ðªï¸', tornado.x, tornado.y);
            }
            
            /**
             * Generates the weather buttons for the cheat menu.
             */
            function generateWeatherMenu() {
                const weatherMenu = document.getElementById('weather-menu');
                weatherMenu.innerHTML = '';
                
                // Show a button for each possible weather state
                allWeatherOptions.forEach(weatherType =&gt; {
                    const button = document.createElement('button');
                    button.className = 'weather-button';
                    button.textContent = weatherIcons[weatherType];
                    button.onclick = () =&gt; {
                        changeWeather(weatherType);
                    };
                    weatherMenu.appendChild(button);
                });
            }


            // Game loop for animations and drawing
            function gameLoop() {
                updatePeople();
                updateBirds();
                updateTornado();
                drawGrid();
                drawPeople();
                drawBirds();
                drawTornado();
                requestAnimationFrame(gameLoop);
            }

            // Event listeners
            canvas.addEventListener('click', (e) =&gt; {
                const rect = canvas.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;

                const gridX = Math.floor(x / scaledTileSize);
                const gridY = Math.floor(y / scaledTileSize);

                if (gridX &gt;= 0 &amp;&amp; gridX &lt; GRID_SIZE &amp;&amp; gridY &gt;= 0 &amp;&amp; gridY &lt; GRID_SIZE) {
                    if (isDeleting) {
                        deleteBuilding(gridX, gridY);
                    } else {
                        placeBuilding(gridX, gridY);
                    }
                }
            });

            canvas.addEventListener('mousemove', (e) =&gt; {
                const rect = canvas.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                
                const gridX = Math.floor(x / scaledTileSize);
                const gridY = Math.floor(y / scaledTileSize);

                if (gridX &gt;= 0 &amp;&amp; gridX &lt; GRID_SIZE &amp;&amp; gridY &gt;= 0 &amp;&amp; gridY &lt; GRID_SIZE) {
                    hoverPosition = { x: gridX, y: gridY };
                    
                    // --- NEW TOOLTIP LOGIC ---
                    if (selectedBuilding) {
                         const building = buildings[selectedBuilding];
                         buildingTooltip.textContent = `${building.name} ($${building.cost})`;
                         buildingTooltip.style.left = `${e.clientX + 10}px`;
                         buildingTooltip.style.top = `${e.clientY + 10}px`;
                         buildingTooltip.style.opacity = 1;
                    } else {
                         buildingTooltip.style.opacity = 0;
                    }

                } else {
                    hoverPosition = { x: -1, y: -1 };
                    buildingTooltip.style.opacity = 0;
                }
                drawGrid();
            });
            
            // Handle touch events for mobile devices
            canvas.addEventListener('touchstart', (e) =&gt; {
                e.preventDefault();
                const touch = e.touches[0];
                const rect = canvas.getBoundingClientRect();
                const x = touch.clientX - rect.left;
                const y = touch.clientY - rect.top;
            
                const gridX = Math.floor(x / scaledTileSize);
                const gridY = Math.floor(y / scaledTileSize);
            
                if (gridX &gt;= 0 &amp;&amp; gridX &lt; GRID_SIZE &amp;&amp; gridY &gt;= 0 &amp;&amp; gridY &lt; GRID_SIZE) {
                    hoverPosition = { x: gridX, y: gridY };
                    if (isDeleting) {
                        deleteBuilding(gridX, gridY);
                    } else {
                        placeBuilding(gridX, gridY);
                    }
                }
            });
            
            canvas.addEventListener('touchmove', (e) =&gt; {
                 e.preventDefault();
                 const touch = e.touches[0];
                 const rect = canvas.getBoundingClientRect();
                 const x = touch.clientX - rect.left;
                 const y = touch.clientY - rect.top;
                 
                 const gridX = Math.floor(x / scaledTileSize);
                 const gridY = Math.floor(y / scaledTileSize);
                 
                 if (gridX &gt;= 0 &amp;&amp; gridX &lt; GRID_SIZE &amp;&amp; gridY &gt;= 0 &amp;&amp; gridY &lt; GRID_SIZE) {
                     hoverPosition = { x: gridX, y: gridY };
                 } else {
                     hoverPosition = { x: -1, y: -1 };
                 }
                 drawGrid();
            });
            
            canvas.addEventListener('mouseleave', () =&gt; {
                buildingTooltip.style.opacity = 0;
            });

            clearButton.addEventListener('click', () =&gt; {
                initializeGrid();
                money = 500;
                population = 0;
                power = 0;
                happiness = 0;
                people = [];
                birds = []; // Reset birds
                tornado = null; // Reset tornado
                currentWeather = 'sunny'; // Reset weather
                weatherStat.textContent = weatherIcons['sunny'];
                updateStats();
                drawGrid();
                updateGuiColor();
                showMessage('Grid cleared!');
            });
            
            deleteButton.addEventListener('click', () =&gt; {
                // Toggle delete mode
                isDeleting = !isDeleting;
                
                // Deselect any building buttons
                selectedBuilding = null;
                document.querySelectorAll('.building-button').forEach(btn =&gt; btn.classList.remove('selected'));
                
                // Highlight the delete button if active
                if (isDeleting) {
                    deleteButton.classList.add('selected');
                    showMessage('Delete mode activated. Click a building to delete it.');
                } else {
                    deleteButton.classList.remove('selected');
                    showMessage('Delete mode deactivated.');
                }
                drawGrid();
            });
            
            // Event listener for the command input box
            commandInput.addEventListener('keydown', (e) =&gt; {
                if (e.key === 'Enter') {
                    const command = commandInput.value.toLowerCase().trim();
                    if (command === 'richnow') {
                        money = 999999999;
                        population = 999999999;
                        power = 999999999;
                        updateStats();
                        showMessage('Cheat activated: You are now rich!');
                    } else if (command === 'weather') {
                        weatherCheatUnlocked = true;
                        weatherCheatPanel.classList.remove('hidden');
                        generateWeatherMenu();
                        showMessage('Weather control menu unlocked!');
                    } else {
                        showMessage('Unknown command.');
                    }
                    commandInput.value = ''; // Clear the input box after command
                }
            });
            
            // New event listener for clicking the game title
            gameTitle.addEventListener('click', () =&gt; {
                commandPanel.classList.toggle('hidden');
            });

            // Re-render the grid on window resize
            window.addEventListener('resize', () =&gt; {
                canvas.width = canvas.parentElement.offsetWidth;
                canvas.height = canvas.width;
                drawGrid();
            });

            // Initialize game
            initializeGrid();
            generateBuildingMenu();
            updateStats();
            updateGuiColor();
            
            // Game loop to update stats every 2 seconds
            setInterval(updateStats, UPDATE_INTERVAL);
            // New interval for changing weather every 2 minutes
            setInterval(changeWeather, WEATHER_CHANGE_INTERVAL);
            // New interval for changing altar states every 10 minutes
            setInterval(changeAltarStates, ALTAR_STATE_CHANGE_INTERVAL);
            
            // Start the main game loop
            gameLoop();
        });
    &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;
 </pre>
</body>
</html>
