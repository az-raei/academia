import numpy as np
import matplotlib.pyplot as plt

# gridworld environment
class gridworld:
    def __init__(self, grid_size=5):
        self.grid_size = grid_size
        self.start = (0, 0)
        self.goal = (4, 4)
        self.obstacles = {(1, 1), (2, 2), (3, 1), (3, 3), (1, 3)}
        self.actions = {'UP': (-1, 0), 'DOWN': (1, 0), 'LEFT': (0, -1), 'RIGHT': (0, 1)}
        self.action_list = list(self.actions.keys())
    
    def is_valid(self, state):
        r, c = state
        return 0 <= r < self.grid_size and 0 <= c < self.grid_size and state not in self.obstacles
    
    def step(self, state, action):
        if state == self.goal:
            return state, 0, True
        
        dr, dc = self.actions[action]
        next_state = (state[0] + dr, state[1] + dc)
        
        #check bounds and obstacles
        if not self.is_valid(next_state):
            return state, -10, False  #obstacle or out of bounds
        
        #check if goal reached
        if next_state == self.goal:
            return next_state, 100, True
        
        return next_state, -1, False  #regular step

#qlearning
def q_learning(env, episodes=1000, alpha=0.1, gamma=0.99, epsilon=0.1):
    #qtable
    Q = np.zeros((env.grid_size, env.grid_size, len(env.action_list)))
    episode_rewards = []
    
    for ep in range(episodes):
        state = env.start
        episode_reward = 0
        done = False
        
        while not done:
            #epsilon greedy action selection
            if np.random.random() < epsilon:
                action_idx = np.random.randint(len(env.action_list))
            else:
                action_idx = np.argmax(Q[state[0], state[1], :])
            
            action = env.action_list[action_idx]
            next_state, reward, done = env.step(state, action)
            episode_reward += reward
            
            #qlearning update
            next_action_idx = np.argmax(Q[next_state[0], next_state[1], :])
            Q[state[0], state[1], action_idx] += alpha *(reward+gamma*Q[next_state[0], next_state[1], next_action_idx]- Q[state[0], state[1], action_idx])
            state = next_state
        
        episode_rewards.append(episode_reward)
    
    return Q, episode_rewards

#extract optimal policy
def extract_policy(Q, env):
    policy = np.empty((env.grid_size, env.grid_size), dtype=str)
    for i in range(env.grid_size):
        for j in range(env.grid_size):
            policy[i, j] = env.action_list[np.argmax(Q[i, j, :])]
    return policy

#main execution
env = gridworld()
Q, episode_rewards = q_learning(env, episodes=1000, alpha=0.1, gamma=0.99, epsilon=0.1)
policy = extract_policy(Q, env)

#plot episode rewards
plt.figure(figsize=(10, 5))
plt.plot(episode_rewards, linewidth=1)
plt.xlabel("episode")
plt.ylabel("total reward")
plt.title("qlearning- total reward per episode")
plt.grid(True)
plt.show()

#display optimal policy
print("optimal policy- ")
print(policy)