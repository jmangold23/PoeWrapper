# Import necessary libraries:
import asyncio  # For asynchronous I/O operations.
import argparse  # For parsing command line arguments.
# Import specific classes from a custom package presumably designed for interfacing with a chat bot.
from fastapi_poe.types import ProtocolMessage  # For creating messages with a specific structure.
from fastapi_poe.client import get_bot_response  # Function to get bot's response.

# Define a class to manage chat interactions with a bot.
class ChatConductor:
    # Constructor for the class.
    def __init__(self, api_key, bot_name):
        self.api_key = api_key  # Store the API key for bot authentication.
        self.bot_name = bot_name  # Store the name of the bot.

    # Asynchronous private method to get responses from the bot.
    async def _get_responses(self, user_content, system_content=None):
        # Prepare the user message in the required format.
        messages = [ProtocolMessage(role="user", content=user_content)]
        # If there is a system message, prepend it to the messages list.
        if system_content:
            messages.insert(0, ProtocolMessage(role="system", content=system_content))
        
        # Initialize an empty string to accumulate the bot's response(s).
        combined_text = ''
        # Asynchronously get the bot's response(s) using the provided messages.
        async for partial in get_bot_response(messages=messages, bot_name=self.bot_name, api_key=self.api_key):
            combined_text += partial.text  # Append each part of the bot's response to the combined text.
        # Return the accumulated response text.
        return combined_text

    # Synchronous method to run the asynchronous method above and return the bot's response.
    def run(self, user_content, system_content=None):
        # Use asyncio.run to execute the asynchronous method synchronously and return its result.
        return asyncio.run(self._get_responses(user_content, system_content))

# This block will only execute if the script is run directly (not imported as a module).
if __name__ == "__main__":
    # Initialize the argument parser with a description of the script's purpose.
    parser = argparse.ArgumentParser(description='Run chat bot interaction and return response in JSON format.')
    # Define expected command line arguments and their properties.
    parser.add_argument('-ApiKey', type=str, help='API key for bot authentication')
    parser.add_argument('-BotName', type=str, help='Name of the bot', default='chatgpt')
    parser.add_argument('-UserMessage', type=str, help='User message to send to the bot')
    parser.add_argument('-SystemMessage', type=str, help='Optional system message to send to the bot', default='You are a helpful chat bot.')

    # Parse the arguments provided to the script.
    args = parser.parse_args()

    # Create an instance of ChatConductor with the provided API key and bot name.
    CC = ChatConductor(args.ApiKey, args.BotName)
    # Print the bot's response to the console by running the `run` method with user and system messages.
    print(CC.run(args.UserMessage, args.SystemMessage))
