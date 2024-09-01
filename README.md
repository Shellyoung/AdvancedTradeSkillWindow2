# Advanced Trade Skill Window 2
Improved window for your professions for World of Warcraft vanilla

<sub>version 2.1.3</sub>

![Face](https://github.com/Shellyoung/AdvancedTradeSkillWindow2/assets/40469927/03e89d75-14f0-417a-8c27-808cb54ce29f)


## Modified by Ayri of Turtle-WoW:
### August 2024 - v2.1.3 Bug Fixes
Reagents required for crafting were bugged to ONLY work in 'SAY' channel.  Modified code starts at line 4156 in file 'AdvancedTradeSkillWindow2.lua'.  
Bugfixed to support ALL channels including: SAY, WHISPER, CHANNEL, YELL, PARTY/GROUP, GUILD, and RAID chats.  
Details in ReadMe.txt

  Advanced Trade Skill Window 2 is a replacement for the standard tradeskill window.
  
  Most buttons in ATSW are self-explaining.
  
  ## Features
  ### Tasks
  Selected recipe can be placed into the task list for later craft by clicking on the "Task" button.
  
  ### Task progress timer
  ![Progress face](https://user-images.githubusercontent.com/40469927/189532773-1d745b82-9a98-4db6-919d-4ba86f0b4ab2.png)
  
  Task progress timer represent overall completion of a task. When you start crafting, the progress timer will appear under the task.


  ### Search commands
  
  ![Search commands face](https://user-images.githubusercontent.com/40469927/189532786-b064c4fe-b156-42df-b45f-09bed5b6e3d3.png)
  
  ATSW has a search function built-in. If you type some text into the search box then ATSW will filter the recipe list according to your entry or the following parameters: **:reagent**, **:level**, **:quality**, **:possible**, **:possibletotal**. You can even combine multiple parameters and a text for a name search, like this:
"**leather :level 20+ :quality uncommon+**" - show recipes with the word "leather" in their name, a minimum level requirement of 20 and a minimum quality of "green".
  
  
  ### Necessary reagents list
  
  ![Necessaries face](https://user-images.githubusercontent.com/40469927/189532793-dc72aceb-4eac-4e72-9b86-9cdec2fc4e3e.png)
  
  The "Reagents" button will show you a list of reagents required to craft items in the task list, amount of the reagents you have in your inventory, in your bank, on alternative characters on the same server and if a reagent can be bought from a merchant. By hovering a cursor over the reagent count on alternative characters, you get a list of all alts currently possessing the reagent.

  ATSW can also automatically buy necessary items from a merchant when speaking to him - either manually by clicking a button in the reagents window or automatically when opening the merchant window.
  
  ### Auction shopping list
  
  ![Shopping list face](https://user-images.githubusercontent.com/40469927/189533362-11b26c25-e929-4da5-a89a-39200e7d4507.png)
  
  Auction shopping list appear under the auction window when it is opened. It shows reagents that are necessary to craft the items in the task list. ATSW is compatible with [aux](https://github.com/shirsig/aux-addon-vanilla).
  
  ### Custom categories
  
  ![Custom face](https://github.com/Shellyoung/AdvancedTradeSkillWindow2/assets/40469927/c526b0c1-c03d-4619-bb4a-2b9d86d99f40)



  You can create categories and put recipes into them.
  
  
  ### Reporting

  By clicking on an item with chat line opened and Shift key pressed ATSW will add a list of the reagents necessary to create a single item into the chat window. ATSW is compatible with [WIM](https://github.com/shirsig/WIM).
  
  
  ### Key bind
  
  ![Key bind](https://github.com/Shellyoung/AdvancedTradeSkillWindow2/assets/40469927/62774995-5b4c-4c32-88b1-7367ea3de545)


  
  A key can be assigned to call ATSW.
  
  
  ### Configuration
  
  ![Config face](https://github.com/Shellyoung/AdvancedTradeSkillWindow2/assets/40469927/14bb999e-3cf2-4657-8dfd-728f545a7169)

  
  ATSW can be configured via built-in options menu. The menu can be shown by entering chat command **/atsw config**.


  ### Localization
  Supported languages: English, Русский, Español, Français, Deutsch

  ## Installation
  1. Download the following archive: [AdvancedTradeSkillWindow2.rar](https://github.com/Shellyoung/Advanced-Trade-Skill-Window/releases/download/2.1.3/AdvancedTradeSkillWindow2.rar)
  
  2. Extract the folder	**AdvancedTradeSkillWindow2** from the archive and place it into the folder **World of Warcraft\Interface\Addons**.
  
  ## Credits
  
  ###### Original idea:
  **Rene Schneider** (**Slarti** on EU-Blackhand) in 2006 
  
  ###### Fixes prior to version 2.0.0:
  [**LaYt**](https://github.com/laytya) in 2017
  
  ###### Blizzard Interface source code:
  https://www.townlong-yak.com/framexml/1.12.1
  
  ###### API Documentation:
  https://wowwiki-archive.fandom.com/wiki/Category:Interface_customization

  ###### Thank you
  Bug reporting and suggestions: [MasterBruin](https://github.com/MasterBruin), [shikulja](https://github.com/shikulja), [TerrorBlades](https://github.com/TerrorBlades), [flyinbed](https://github.com/flyinbed), [asfddhdjkdghkghhgdsfn](https://github.com/asfddhdjkdghkghhgdsfn).
  
  翻译成中文: [flyinbed](https://github.com/flyinbed)
