<template>
    <div v-on:click="showStats = !showStats">
        <div class="summary switcher" :class="{ switched: showStats }">
            <div class="switcher-wrapper">
                <ol>
                    <li v-for="type in order">
                        <span class="vote-color" :class="[type]"></span>
                        {{ type }}: {{ synthese.decompte[type] }}
                    </li>
                </ol>
                <ol>
                    <li>Votants: {{ synthese.nombreVotants }}</li>
                    <li>Exprimés: {{ synthese.suffragesExprimes }}</li>
                    <li>Requis: {{ synthese.nbrSuffragesRequis }}</li>
                </ol>
            </div>
        </div>
        <div class="graph">
            <div v-for="votes in orderedRepartition" :style="votes.style" :class="[votes.type]" :aria-label="votes.type">
                {{ votes.type }}
            </div>
        </div>
    </div>
</template>

<script>
const order = ['pour', 'abstention', 'contre', 'nonVotant']

export default {
    props: ['synthese'],
    data: ()=>{
        return {
            showStats: false,
            order
        }
    },
    computed: {
        totalVotes(){
            return order.reduce((acc, type)=> acc += this.synthese.decompte[type] || 0, 0)
        },

        orderedRepartition(){
            const totalVotes = this.totalVotes

            return order.map(type => {
                const total = this.synthese.decompte[type] || 0
                return {
                    type,
                    total,
                    style: {
                        width: `${total / totalVotes * 100}%`
                    }
                }
            })
        }
    }
}
</script>

<style lang="scss" scoped>
    @import '../styles/vars.scss';

    .pour {
        background-color: $blue;
    }

    .contre {
        background-color: $red;
    }

    .nonVotant {
        background-color: $light-gray;
    }

    .abstention {
        &.vote-color {
            border: 1px solid $gray;
        }
    }

    .summary {
        height: 40px;
        box-shadow: 0px 0px 3px 0px rgba(black, 0.3) inset;

        ol {
            display: table;
            padding-left: 0;
        }

        li {
            display: table-cell;
            width: 1%;
            text-align: center;
            vertical-align: middle;
            font-size: .7em;
            white-space: nowrap;
        }
    }

    .vote-color {
        display: inline-block;
        width: 10px;
        height: 10px;
        border-radius: 50%;
    }

    .switcher {
        overflow: hidden;

        &.switched {
            .switcher-wrapper {
                top: -100%;
            }
        }

        .switcher-wrapper {
            position: relative;
            top: 0;
            height: 200%;
            transition: top .25s ease-in-out;

            > * {
                margin: 0;
                height: 50%;
            }
        }
    }

    .graph {
        cursor: pointer;
        overflow: hidden;
        line-height: 14px;

        > div {
            display: inline-block;
            text-indent: -9999px;
        }
    }
</style>
