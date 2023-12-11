import matplotlib.pyplot as plt
import pandas as pd


def format_number(num):
    if num >= 1000000000:
        return f'{num / 1000000000:.1f}B'
    elif num >= 1000000:
        return f'{num / 1000000:.1f}M'
    elif num >= 1000:
        return f'{num / 1000:.1f}K'
    else:
        return str(num)


if __name__ == '__main__':
    df = pd.read_csv('data.csv')
    df['cpr'] = df['cycle'] / df['request']

    # Normalize data
    original_cycles = df['cycle'].copy()
    original_requests = df['request'].copy()
    original_cycles_per_request = df['cpr'].copy()

    df['cycle'] = df['cycle'] / df['cycle'].max()
    df['request'] = df['request'] / df['request'].max()
    df['cpr'] = df['cpr'] / df['cpr'].max()

    # Draw charts
    bax = df.plot(kind='bar', title='Web Framework Performance Comparison', x='name',
                  ylabel='Normalized CPU Cycles and Requests', y=['cycle', 'request'], figsize=(10, 6))
    lax = df.plot(xlabel='Framework', x='name', ylabel='Normalized CPU Cycles per Request', y='cpr',
                  marker='o', color='red', ax=bax, secondary_y=True)

    # Modify legend labels
    bar_lines, bar_labels = bax.get_legend_handles_labels()
    dot_lines, dot_labels = lax.get_legend_handles_labels()
    lines, labels = bar_lines + dot_lines, bar_labels + dot_labels

    labels[labels.index('cycle')] = 'CPU Cycles'
    labels[labels.index('request')] = 'Requests'
    labels[labels.index('cpr (right)')] = 'CPU Cycles per Request'

    bax.legend(lines, labels)

    # Annotating bars
    for i, bar in enumerate(bax.patches):
        if i < len(df):  # cycle bars
            bax.annotate(format_number(original_cycles[i]), (bar.get_x() + bar.get_width() / 2, bar.get_height()),
                         ha='center', va='bottom')
        else:  # request bars
            bax.annotate(format_number(original_requests[i - len(df)]),
                         (bar.get_x() + bar.get_width() / 2, bar.get_height()), ha='center', va='bottom')

    # Annotating line points
    for i, point in enumerate(df['cpr']):
        lax.annotate(format_number(original_cycles_per_request[i]), (i, point),
                     textcoords="offset points", xytext=(0, 10), ha='center')

    plt.savefig('img/chart.svg', format='svg')
