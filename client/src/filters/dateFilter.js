import moment from 'moment'

export default function dateFilter(value, format) {
    return moment(value).format(format)
}
